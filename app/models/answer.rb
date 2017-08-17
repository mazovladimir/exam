class Answer < ApplicationRecord
  belongs_to :question, inverse_of: :answers, optional: true

  validates :give, length: { minimum: 1, maximum: 300, message: "Пожалуйста, введите ответ не меньше 1 и не более 300 символов"}
  validates :give,  presence: { message: "Поле ответа не может быть пустым" }
end
