class AddMultipleAnswersToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :multiple_answers, :boolean, default: false
  end
end
