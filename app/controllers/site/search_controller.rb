# frozen_string_literal: true

class Site::SearchController < SiteController
  def questions
    term = params[:term].downcase
    @questions = Question._search_(term, params[:page])
  end
end
