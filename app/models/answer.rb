class Answer < ApplicationRecord
  validate :validate_answer

  belongs_to :question

  def validate_answer
    self.question.errors.add(:base, "Пожалуйста, введите ответ не меньше 1 и не более 1000 символов") if self.give.length > 1000 || self.give.length < 1
  end 
end
