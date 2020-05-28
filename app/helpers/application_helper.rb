# frozen_string_literal: true

module ApplicationHelper

  def logout_user
    logout_builder('Fazer logout [Usuário]', destroy_user_session_path)
  end

  private

  def logout_with_icon(text,route)
    link_to route, method: :delete do
      yield
      text
    end
  end

  def logout_builder(link_text, route)
    if block_given?
      logout_with_icon(link_text,route) { block.call }
    else
      link_to link_text, route, method: :delete
    end
  end
end
