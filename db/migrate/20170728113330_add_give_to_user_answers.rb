class AddGiveToUserAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :user_answers, :give, :string
  end
end
