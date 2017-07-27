class UserAnswer < ApplicationRecord
  has_many :user_question_useranswers
  has_many :users, through: :user_question_useranswers

  has_many :user_question_useranswers
  has_many :questions, through: :user_question_useranswers
end
