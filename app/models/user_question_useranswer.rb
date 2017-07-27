class UserQuestionUseranswer < ApplicationRecord
  belongs_to :question
  belongs_to :user_answer, optional: true
  belongs_to :user
end
