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
    params[:question][:choice].split("\r\n").reject { |c| c.empty? }.map {|x| @question.answers.build(give: x)}

    if @question.save
      redirect_to questions_path, notice: "Вопрос был успешно создан"
    else
      render 'new'
    end
  end

  def update
    if params[:question][:choice].split("\r\n").reject { |c| c.empty? } != @question.answers.map(&:give)
      ActiveRecord::Base.transaction do
        @question.answers.destroy_all
        params[:question][:choice].split("\r\n").reject { |c| c.empty? }.map {|x| @question.answers.build(give: x)}
      end
    end

    if @question.update(question_params)
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
    params.require(:question).permit(:examinee_answer, :ask, :correct_answer, :choice)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
