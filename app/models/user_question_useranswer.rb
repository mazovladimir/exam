class UserQuestionUseranswer < ApplicationRecord

  belongs_to :question, optional: true
  belongs_to :user_answer, optional: true
  belongs_to :user, optional: true

end
