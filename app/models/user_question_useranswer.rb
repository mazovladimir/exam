class UserQuestionUseranswer < ApplicationRecord
  belongs_to :question, optional: true
  belongs_to :user_answer, optional: true
  belongs_to :user, optional: true

  def next(user)
    unless self.nil?
      index = user.user_question_useranswers.index(self)
      next_id = user.user_question_useranswers[index+1] unless index == user.user_question_useranswers.index(user.user_question_useranswers.last)
      #self.class.find_by_id(next_id)
      user.user_question_useranswers.find(next_id.id).question
    end
  end
end
