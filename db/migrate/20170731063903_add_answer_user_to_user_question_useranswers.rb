class AddAnswerUserToUserQuestionUseranswers < ActiveRecord::Migration[5.0]
  def change
    add_column :user_question_useranswers, :answer_user, :string
  end
end
