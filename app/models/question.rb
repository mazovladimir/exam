class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :questions_users
  has_many :users, through: :questions_users

  def generate_questions
    
  end
end
