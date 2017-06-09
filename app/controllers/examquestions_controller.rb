class ExamquestionsController < ApplicationController
  before_action :set_user, only: [ :create, :show, :next_question, :prev_question ]

  def create 
    @user.questions = Question.all.sample(3) if current_user.questions.empty?
    @examquestion = @user.questions.first
    render :show
  end

  def next_question
    @examquestion = @user.questions.find { |q| q.id > params[:id].to_i }
    render :show
  end

  def prev_question
    @examquestion = @user.questions.reverse.find { |q| q.id < params[:id].to_i }
    render :show
  end

  def show
    @examquestion = @user.questions.find { |q| q.id > params[:id].to_i }
  end

  #if @examquestion.update(examquestion_params)
  #  redirect_to questions_path
  #else
  #  render 'edit'
  #end

  private

  #def examquestion_params
  #  params.require(:examquestion).permit(:score)
  #end

  def set_user
    @user = User.find(params[:user_id])
  end
end
