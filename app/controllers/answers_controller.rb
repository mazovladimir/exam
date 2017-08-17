class AnswersController < ApplicationController
  before_action :set_answer, only: [ :destroy ]

  def destroy
    @answer.destroy
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
