class ExamQuestion < ApplicationRecord
  belongs_to :user
  has_many :exam_answers
end
