class Question < ApplicationRecord
  belongs_to :subject
  paginates_per 25

  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers
end
