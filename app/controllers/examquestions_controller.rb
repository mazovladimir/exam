class ExamquestionsController < ApplicationController
  before_action :set_examquestion, only: [ :next_question, :prev_question ]

  def index
    Question.all.sample(5).map {|x| current_user.user_question_useranswers.create(question: x)} if current_user.user_question_useranswers.count < 5
    @question = current_user.user_question_useranswers.map {|x| x.question}.first
    @examquestion = @question
  end

  def next_question
    @question = @examquestion.next
  end

  def prev_question
    @question = @examquestion.prev
  end

  private

  def set_examquestion
    @examquestion = Question.find(params[:id])
  end
end
