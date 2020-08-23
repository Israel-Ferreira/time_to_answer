# frozen_string_literal: true

class Site::SearchController < SiteController
  def questions
    term = params[:term].downcase
    @questions = Question._search_(term, params[:page])
  end

  def subject
    @questions = Question.search_by_subject(params[:page], params[:subject_id])
  end
end
