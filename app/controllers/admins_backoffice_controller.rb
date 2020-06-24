class AdminsBackofficeController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins_backoffice'

  def after_sign_in_path_for(resource)
    redirect_to admins_backoffice_welcome_index_path
  end
end
