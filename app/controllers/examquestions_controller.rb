class ExamquestionsController < ApplicationController
  before_action :set_examquestion, only: [ :move_question ]

  def index
    @examquestions = Question.all.sample(5)
    if @examquestions.count == 5 
      current_user.questions = @examquestions if current_user.questions.count < 5
    else
      flash.alert = "Questions not available, please contact course administrator"
    end
    @question = current_user.questions.first
  end

  def move_question
    @question = @examquestion.next(current_user) if params[:commit] == 'Next'
    @question = @examquestion.prev(current_user) if params[:commit] == 'Prev'
    current_index = current_user.questions.index(@examquestion)
    current_user.user_question_useranswers[current_index].update(answer_user: params[:answer]) if ! params[:answer].nil?
  end

  private

  def set_examquestion
    @examquestion = Question.find(params[:id])
  end
end
