class AddExamineeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :examinee_answer, :string
  end
end
