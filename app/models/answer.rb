class Answer < ApplicationRecord
  validates :give, presence: true, length: { maximum: 1000 }
  belongs_to :question
end
