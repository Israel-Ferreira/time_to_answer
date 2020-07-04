class Subject < ApplicationRecord
  validates :description, presence: true
  paginates_per 15
end
