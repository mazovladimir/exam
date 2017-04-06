class QuestionsController < ApplicationController
  before_action :set_question, only: [ :edit, :update, :destroy ]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to questions_path
    else
      render 'new'
    end
  end

  def update
    #@question.update(score: 'true') if score_answer == @question.answer
    if @question.update(question_params) 
      redirect_to questions_path
    else
      render 'edit'
    end
    #@question.update(score: true) if @question.correct_answer == @question.examinee_answer
    #redirect_to action: "new"
  end

  def destroy
    @question.destroy
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:examinee_answer, :ask, :correct_answer, :choice)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end

