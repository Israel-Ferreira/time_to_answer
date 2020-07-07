class Subject < ApplicationRecord
  validates :description, presence: true
  has_many :questions
  paginates_per 15
end
