class Question < ApplicationRecord
  attr_accessor :correct
  attr_accessor :choice

  validates :ask, uniqueness: { message: "Такой вопрос уже существует"}
  validates :ask, length: { minimum: 5, maximum: 1000, message: "Пожалуйста, введите вопрос не меньше 5 и не более 1000 символов"}
  validates :correct, presence: { message: "Поле 'Правильный ответ' не может быть пустым"}  

  validate :validate_correct, :validate_choice


  def validate_correct
    self.errors.add(:base, "Не все правильные ответы входят в список вариантов ответа") if (self.correct_answers.map(&:give) - self.answers.map(&:give)).any?
    self.errors.add(:base, "Правильные ответы совпадают, удалите дубликаты") if self.correct_answers.map(&:give).uniq.size != self.correct_answers.map(&:give).size
  end

  def validate_choice
    self.errors.add(:base, "Вариантов ответа должно быть больше одного") if self.answers.size < 2
    self.errors.add(:base, "Варианты ответа совпадают, удалите дубликаты") if self.answers.map(&:give).uniq.size != self.answers.map(&:give).size
  end

  before_save :set_multiple_answers

  has_many :answers, dependent: :destroy
  has_many :questions_users
  has_many :users, through: :questions_users
  has_many :correct_answers, dependent: :destroy

  def update_transaction?(question_params)
    transaction do
      assign_attributes(ask: question_params[:ask])
      correct_answers.destroy_all if question_params[:correct] != correct_answers.map(&:give)
      answers.destroy_all if question_params[:choice] != answers.map(&:give)
      params_correct_choice(question_params[:choice], answers) if answers.empty?
      params_correct_choice(question_params[:correct], correct_answers) if correct_answers.empty?
      update!(question_params)
    end
    rescue ActiveRecord::RecordInvalid 
  end

  def params_correct_choice(question_params,question_method)
    question_params.split("\r\n").map(&:strip).reject(&:empty?).map {|p| question_method.build(give: p)}
  end

  private

  def set_multiple_answers
    assign_attributes(multiple_answers: true) if correct_answers.size > 1
    assign_attributes(multiple_answers: false) if correct_answers.size == 1
  end
end
