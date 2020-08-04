# frozen_string_literal: true

class Site::WelcomeController < SiteController
  def index
    @questions = Question.includes(:answers).page(params[:page])
  end
end
