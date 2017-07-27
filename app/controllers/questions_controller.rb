class QuestionsController < ApplicationController
  before_action :set_question, only: [ :edit, :update, :destroy ]

  def index
    @questions = Question.all
    @user = current_user
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.user_question_useranswers.build(user_id: current_user.id)
    @question.params_correct_choice(question_params[:choice], @question.answers)
    @question.params_correct_choice(question_params[:correct], @question.correct_answers)

    if @question.save
      redirect_to questions_path, notice: "Вопрос был успешно создан"
    else
      render 'new'
    end
  end

  def update
    if @question.update_transaction?(question_params)
      redirect_to questions_path, notice: "Вопрос был успешно обновлен"
    else
      render 'edit'
    end
  end

  def destroy
    @questions = Question.all
    @question.destroy
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:ask, :correct, :choice)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
