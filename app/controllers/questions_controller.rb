class QuestionsController < ApplicationController
  before_action :set_question, only: [ :show, :edit, :update, :destroy ]

  def index
    @questions = Question.all
    @user = current_user
  end

  def new
    @question = Question.new
    2.times { @question.answers.build}
  end

  def edit
  end

  def show
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    params[:question][:answers_attributes].each { |key,value| value.correct_answer = true if value[:correct_answer] == 1 }

    if @question.save
      redirect_to questions_path, notice: "Вопрос был успешно создан"
    else
      render 'new'
    end
  end

  def update
    if @question.update(question_params)
      redirect_to questions_path, notice: "Вопрос был успешно обновлен"
    else
      render 'edit'
    end
  end

  def destroy
    if @question.destroy
      redirect_to questions_path, notice: "Вопрос был успешно удален"
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:ask, answers_attributes: [:id, :give, :_destroy, :correct_answer, :score])
  end
end
