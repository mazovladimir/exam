class CorrectAnswer < ApplicationRecord
  validate :validate_correct_answer

  belongs_to :question

  def validate_correct_answer
    self.question.errors.add(:base, "Каждый правильный ответ не должен превышать 1000 символов") if self.give.length > 100
  end
end
