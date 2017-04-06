class AddGeneratedToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :give, :string
  end
end
