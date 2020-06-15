# frozen_string_literal: true

class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :set_admin, only: %i[edit update]
  before_action :password_verify, only: %i[update]

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      back_to_admins_list('Admin Criado com sucesso') 
    else
      render :new
    end
  end

  def edit; end

  def update
    if @admin.update(admin_params)
      back_to_admins_list("Admin #{@admin.email} atualizado com sucesso")
    else
      render :edit
    end
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def password_verify
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end
  end

  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end

  def back_to_admins_list(notice_msg)
    redirect_to admins_backoffice_admins_path, notice: notice_msg
  end
end
