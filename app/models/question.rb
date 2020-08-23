# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions
  paginates_per 5

  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  scope :_search_, lambda { |term, page|
    includes(:answers)
      .where('lower(description) LIKE ?', "%#{term}%")
      .page(page)
  }


  scope :search_by_subject, ->(page, subject_id) {
    includes(:answers, :subject)
      .where(subject_id: subject_id)
      .page(page)
  }

  scope :last_questions, lambda { |page|
    includes(:answers).order(created_at: :desc).page(page)
  }
end
