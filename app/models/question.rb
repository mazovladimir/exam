class Question < ApplicationRecord
  validates :ask, :correct_answer, presence: true, length: { maximum: 1000 }

  has_many :answers, dependent: :destroy
  has_many :questions_users
  has_many :users, through: :questions_users

  def self.save_new_question(question,choice,correct_answer)
    array_choices = choice.first.split("\n")
    if array_choices.map(&:strip).include?(correct_answer.to_s)
      ActiveRecord::Base.transaction do
        question.save
        array_choices.each {|x| question.answers.create(give: x)}
      end
    end
  end

  def self.update_question(question,choice,correct_answer)
    array_choices = choice.split("\n")
    if array_choices.map(&:strip).include?(correct_answer.to_s)
      question.answers.destroy_all
      array_choices.each {|x| question.answers.create(give: x)}
    end
  end

  def self.not_duplicate_answers?(question)
    answers = question.answers.map(&:give)
    if answers.find_all { |e| answers.count(e) > 1 } 
      return false
    else
      return true
    end
  end
end
