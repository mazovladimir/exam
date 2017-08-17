class Question < ApplicationRecord
  validates :ask, uniqueness: { message: "Такой вопрос уже существует"}
  validates :ask, length: { minimum: 5, maximum: 1000, message: "Пожалуйста, введите вопрос не меньше 5 и не более 1000 символов"}

  belongs_to :user

  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers

  #has_many :user_question_useranswers
  #has_many :users, through: :user_question_useranswers

  #has_many :user_question_useranswers
  #has_many :user_answers, through: :user_question_useranswers

  def prev_question(user)
    unless nil?
      index = user.questions.index(self)
      user.questions[index-1] if index > 0
    end
  end

  def next_question(user,user_answer)
    unless nil?
      index = user.questions.index(self)
      #user.questions[index].user_answers << UserAnswer.create(give: user_answer )
      user.user_question_useranswers[index].update(answer_user: user_answer)
      #user.user_question_useranswers[index].update(user_answer: UserAnswer.create(give: user_answer))
      user.questions[index+1] if index < user.questions.count - 1
    end
  end
end
