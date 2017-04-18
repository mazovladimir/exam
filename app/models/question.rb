class Question < ApplicationRecord
  attr_accessor :choice

  validate :validate_question, :validate_correct_answer, :validate_choice

  has_many :answers, dependent: :destroy
  has_many :questions_users
  has_many :users, through: :questions_users

  def validate_question
    self.errors.add(:base, "Пожалуйста, введите вопрос не меньше 10 символов") if self.ask.length < 10
    self.errors.add(:base, "Пожалуйста, введите вопрос не больше 1000 символов") if self.ask.length > 1000
  end

  def validate_correct_answer
    self.errors.add(:base, "Напишите правильный ответ без перевода новой строки") if self.correct_answer.scan(/$|\Z/).count != 1
    self.errors.add(:base, "Поле 'Правильный ответ' не может быть пустым") if split_correct_answer.empty?
  end

  def validate_choice
    self.errors.add(:base, "Вариантов ответа должно быть больше одного") if split_choice.size < 2
    self.errors.add(:base, "Правильный ответ не входит в список вариантов ответов") if ! split_choice.include?(split_correct_answer.first)
    self.errors.add(:base, "Варианты ответа совпадают, удалите дубликаты") if split_choice.uniq.size != split_choice.size
    self.errors.add(:base, "Удалите пустые строки в вариантах ответа") if (self.choice.scan(/$|\Z/).count != split_choice.size) && split_choice.any?
  end

  def split_choice
    return self.choice.split("\r\n")
  end

  def split_correct_answer
    return self.correct_answer.split("\r\n")
  end
end
