class User < ApplicationRecord
  has_many :questions_users
  has_many :questions, through: :questions_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.generate_questions
    self.find(1).questions = Question.all.sample(3)
  end
end
