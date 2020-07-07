# frozen_string_literal: true

class AdminsBackofficeController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins_backoffice'

  def after_sign_in_path_for(_resource)
    redirect_to admins_backoffice_welcome_index_path
  end

  def back_resource_index(index_route, notice_msg)
    redirect_to index_route, notice: notice_msg
  end
end
