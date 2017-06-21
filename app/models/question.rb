class Question < ApplicationRecord
  attr_accessor :correct
  attr_accessor :choice

  validate :validate_question, :validate_correct_answer, :validate_choice

  def validate_question
    self.errors.add(:base, "Пожалуйста, введите вопрос не меньше 10 символов") if self.ask.length < 10
    self.errors.add(:base, "Пожалуйста, введите вопрос не больше 1000 символов") if self.ask.length > 1000
  end

  def validate_correct_answer
    self.errors.add(:base, "Поле 'Правильный ответ' не может быть пустым") if self.correct_answers.size < 1
    self.errors.add(:base, "Пожалуйста, введите правильный ответ не больше 1000 символов") if self.correct_answers.length > 1000
    self.errors.add(:base, "Не все правильные ответы входят в список вариантов ответа") if (self.correct_answers.map(&:give) - self.answers.map(&:give)).any?
    self.errors.add(:base, "Правильные ответы совпадают, удалите дубликаты") if self.correct_answers.map(&:give).uniq.size != self.correct_answers.map(&:give).size
  end

  def validate_choice
    self.errors.add(:base, "Вариантов ответа должно быть больше одного") if self.answers.size < 2
    self.errors.add(:base, "Варианты ответа совпадают, удалите дубликаты") if self.answers.map(&:give).uniq.size != self.answers.map(&:give).size
  end

  after_create :set_multiple_answers

  has_many :answers, dependent: :destroy
  has_many :questions_users
  has_many :users, through: :questions_users
  has_many :correct_answers, dependent: :destroy
  
  
  def self.update_answer(question,correct,choice)
    Question.transaction do
      question.correct_answers.destroy_all unless correct == question.correct_answers.map(&:give)
      question.answers.destroy_all unless choice == question.answers.map(&:give)
      choice.map {|x| question.answers.build(give: x)} if question.answers.empty?
      correct.map {|p| question.correct_answers.build(give: p)} if question.correct_answers.empty?
      question.save!
    end
    rescue ActiveRecord::RecordInvalid 
  end

  private

  def set_multiple_answers
    self.update(multiple_answers: true) if self.correct_answers.size > 1
  end
end
