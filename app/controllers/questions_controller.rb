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
    params_question_choice.map {|x| @question.answers.build(give: x)}
    params_correct_answer.map {|p| @question.correct_answers.build(give: p)}

    if @question.save
      redirect_to questions_path, notice: "Вопрос был успешно создан"
    else
      render 'new'
    end
  end

  def update
    if Question.update_answer(@question, params_correct_answer, params_question_choice)  
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

  def params_question_choice
    params[:question][:choice].split("\r\n").map(&:strip).reject(&:empty?)
  end

  def params_correct_answer
    params[:question][:correct].split("\r\n").map(&:strip).reject(&:empty?)
  end

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
