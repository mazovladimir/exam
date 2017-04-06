class AddCorrectToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :correct_answer, :string
  end
end
