class AddAskToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :ask, :string
  end
end
