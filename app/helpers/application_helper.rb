# frozen_string_literal: true

module ApplicationHelper
  def logout_admin
    logout_builder('Fazer logout [Administrador]', destroy_admin_session_path)
  end

  def logout_user
    logout_builder('Fazer logout [Usuário]', destroy_user_session_path)
  end

  private

  def logout_builder(link_text, route)
    link_to link_text, route, method: :delete
  end
end
