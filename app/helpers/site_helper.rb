module SiteHelper
  def msg_jumbotron
    case params[:action]
    when 'index'
      I18n.translate("site.welcome_message")
    when 'questions'
      "Resultados para o termo: \"#{params[:term]}\"..."
    when 'subject'
      "Mostrando questões para o assunto \"#{params[:subject]}\"..."
    end
  end
end
