class Question < ApplicationRecord
  validates :ask, :correct_answer, presence: true, length: { maximum: 1000 }

  has_many :answers, dependent: :destroy
  has_many :questions_users
  has_many :users, through: :questions_users
end
