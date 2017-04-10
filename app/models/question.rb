class Question < ApplicationRecord
  validates :ask, :correct_answer, presence: true, length: { maximum: 1000 }

  has_many :answers, dependent: :destroy
  has_many :questions_users
  has_many :users, through: :questions_users

  def self.add_answers(question,choice,correct_answer)
    array_choices = choice.first.split("\n")
    if array_choices.map(&:strip).include?(correct_answer.to_s)
      array_choices.each {|x| question.answers.create(give: x)}
    end
  end
end
