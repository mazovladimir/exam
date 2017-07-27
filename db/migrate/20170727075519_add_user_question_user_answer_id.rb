class AddUserQuestionUserAnswerId < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :user_question_useranswers, :user
    add_belongs_to :user_question_useranswers, :question
    add_belongs_to :user_question_useranswers, :user_answer
  end
end
