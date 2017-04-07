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
    @answer_choice = params[:choice]

    if @question.save
      Question.add_answers(@question, @answer_choice)
      redirect_to questions_path
    else
      render 'new'
    end

    
  end

  def update
    if @question.update(question_params) 
      redirect_to questions_path
    else
      render 'edit'
    end
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

