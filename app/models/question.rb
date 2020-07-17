class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions
  paginates_per 25

  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
end
