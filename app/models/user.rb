class User < ApplicationRecord
  #has_many :user_question_useranswers
  #has_many :user_answers, through: :user_question_useranswers

  #has_many :user_question_useranswers
  #has_many :questions, through: :user_question_useranswers

  has_many :questions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
