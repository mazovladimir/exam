class AddGiveToCorrectAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :correct_answers, :give, :string
  end
end
