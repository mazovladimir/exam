class Answer < ApplicationRecord
  validates :give, length: { minimum: 1, maximum: 1000}

  belongs_to :question

  #def validate_answer
  #  self.question.errors.add(:base, "Каждый ответ не должен превышать 1000 символов") if self.give.length > 100
  #end 
end
