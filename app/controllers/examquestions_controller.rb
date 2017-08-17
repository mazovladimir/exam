class ExamquestionsController < ApplicationController
  before_action :set_examquestion, only: [ :check_question ]

  def index
    @examquestions = Question.all.sample(9)
    if @examquestions.count == 9
      current_user.questions = @examquestions if current_user.questions.count < 9
    else
      flash.alert = "Questions not available, please contact course administrator"
    end
    @question = current_user.questions.first
  end

  def move_question
    current_index = current_user.questions.index(@examquestion)
    current_user.user_question_useranswers[current_index].update(user_answer: UserAnswer.create(give: 123))
  end

  def check_question
    @question = @examquestion.next_question(current_user, params[:answer]) if params[:next]
    @question = @examquestion.prev_question(current_user, params[:answer]) if params[:previous]
  end

  def results
    @users = User.all
  end

  private

  def set_examquestion
    @examquestion = Question.find(params[:id])
  end
end
