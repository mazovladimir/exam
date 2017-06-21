class CreateCorrectAnswer < ActiveRecord::Migration[5.0]
  def change
    create_table :correct_answers do |t|

      t.timestamps
    end
  end
end
