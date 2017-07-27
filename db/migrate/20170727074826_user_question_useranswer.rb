class UserQuestionUseranswer < ActiveRecord::Migration[5.0]
  def change
     create_table :user_question_useranswers do |t|

      t.timestamps
    end
  end
end
