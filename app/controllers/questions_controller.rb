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
    @choice = params[:choice].first.split("\r\n")
    @correct_answer = params[:question][:correct_answer]
    @choice.each { |x| @question.answers.build(give: x) }

    if check_answers? && @question.save
      redirect_to questions_path, notice: "Вопрос был успешно создан"
    else
      redirect_to questions_path, alert: "Failed"
    end
  end

  def update
    #@choice = params[:choice].split("\r\n")
    @correct_answer = params[:question][:correct_answer]

    if @question.update(question_params)
      ActiveRecord::Base.transaction do     
        @question.answers.destroy_all
        @choice.each { |x| @question.answers.create(give: x) }
      end  
      redirect_to questions_path, notice: "Вопрос был успешно обновлен"
    else
      #flash[:error] = @question.errors
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

  def check_answers?
    (@choice.uniq.size == @choice.size)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
