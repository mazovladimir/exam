class AddCorrectAnswerToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :correct_answer, :boolean, default: "false"
  end
end
