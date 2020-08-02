# frozen_string_literal: true

class ApplicationController < ActionController::Base
  layout :layout_by_resource

  def after_sign_in_path_for(_resource)
    if resource_class == Admin
      admins_backoffice_welcome_index_path
    else
      users_backoffice_welcome_index_path
    end
  end

  private

  def layout_by_resource
    devise_controller? ? "#{resource_class.to_s.downcase}_devise" : 'application'
  end
end
