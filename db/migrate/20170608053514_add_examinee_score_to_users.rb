class AddExamineeScoreToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :examinee_score, :integer
  end
end
