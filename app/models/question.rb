class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :questions_users
  has_many :users, through: :questions_users

  def self.add_answers(question,question_answers)
    question_answers.first.split("\n").each {|x| question.answers.create(give: x)}
  end
end
