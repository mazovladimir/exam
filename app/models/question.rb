class Question < ApplicationRecord
  attr_accessor :choice
  validate :validate_question, :validate_choice

  has_many :answers, dependent: :destroy
  has_many :questions_users
  has_many :users, through: :questions_users

  def validate_question
    self.errors.add(:base, "Пожалуйста, введите вопрос не меньше 10 символов") if self.ask.length < 10
    self.errors.add(:base, "Пожалуйста, введите вопрос не больше 1000 символов") if self.ask.length > 1000
  end

  def validate_choice
    self.errors.add(:base, "Введите больше одного ответа") if self.choice.split("\r\n").size < 2
    self.errors.add(:base, "Правильный ответ не входит в список вариантов ответов") if ! self.choice.split("\r\n").include?(self.correct_answer)
    self.errors.add(:base, "Варианты ответов совпадают, удалите дубликаты") if self.choice.split("\r\n").uniq.size != self.choice.split("\r\n").size
  end
end
