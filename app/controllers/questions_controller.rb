class QuestionsController < ApplicationController
  before_action :set_question, only: [ :edit, :update, :destroy ]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
    #@question = User.first.questions.first
    #@answers = @question.answers
  end

  def edit
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question
    else
      render 'new'
    end
  end

  def update
    #@question.update(score: 'true') if score_answer == @question.answer
    @question.update(question_params) 
    @question.update(score: true) if @question.correct_answer == @question.examinee_answer
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
    params.require(:question).permit(:examinee_answer, :ask)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end

