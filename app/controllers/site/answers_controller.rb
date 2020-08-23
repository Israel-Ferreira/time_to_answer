class Site::AnswersController < SiteController
  def question
    @answer =  Answer.find(params[:answer_id])
  end
end
