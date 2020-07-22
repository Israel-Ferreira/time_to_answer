# frozen_string_literal: true

class AdminsBackofficeController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins_backoffice'


  def back_resource_index(index_route, notice_msg)
    redirect_to index_route, notice: notice_msg
  end
end
