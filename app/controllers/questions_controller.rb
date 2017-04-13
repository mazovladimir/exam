class QuestionsController < ApplicationController
  before_action :set_question, only: [ :edit, :update, :destroy ]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def edit
    @answer_choice = "Hello"
  end

  def create
    @question = Question.new(question_params)
    @choice = params[:choice]
    @correct_answer = params[:question][:correct_answer]

    if Question.save_new_question(@question, @choice, @correct_answer)
      redirect_to questions_path, notice: "Вопрос был успешно создан"
    else
      redirect_to questions_path, alert: 'Fields not correct'
    end
  end

  def update
    @choice = params[:choice]
    @correct_answer = params[:question][:correct_answer]

    if Question.update_question(@question, @choice, @correct_answer)
      redirect_to questions_path, notice: "Вопрос был успешно обновлен"
    else
      render 'edit'
    end
  end

  def destroy
    if @question.destroy
      redirect_to questions_path
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:examinee_answer, :ask, :correct_answer)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end

