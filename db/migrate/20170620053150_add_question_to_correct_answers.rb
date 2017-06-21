class AddQuestionToCorrectAnswers < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :correct_answers, :question
  end
end
