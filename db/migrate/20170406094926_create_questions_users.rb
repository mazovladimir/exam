class CreateQuestionsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :questions_users do |t|
      t.integer :question_id
      t.integer :user_id
    end
  end
end
