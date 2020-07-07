class Question < ApplicationRecord
  belongs_to :subject
  paginates_per 25
end
