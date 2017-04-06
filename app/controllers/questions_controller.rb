class QuestionsController < ApplicationController

  def new
    @question = Question.first
    @answers = @question.answers
  end

  def update
    @question = Question.find(params[:id])
    #@question.update(score: 'true') if score_answer == @question.answer
    @question.update(question_params) 
    @question.update(score: true) if @question.correct_answer == @question.examinee_answer
    #redirect_to action: "new"
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:examinee_answer)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end

