# frozen_string_literal: true

namespace :dev do
  DEFAULT_PASSWORD = 123456

  desc 'TODO'
  task setup: :environment do
    if Rails.env.development?
      tasks = [
        { command: 'db:drop', start_msg: 'Apagando o banco de dados', end_msg: 'Banco de dados apagado com sucesso' },
        { command: 'db:create', start_msg: 'Criando o banco de dados', end_msg: 'Banco de dados criado com sucesso' },
        { command: 'db:migrate', start_msg: 'Migrando o BD', end_msg: 'Migração realizada com sucesso' },
        { command: 'dev:add_default_admin', start_msg: 'Criando o Admin ...', end_msg: 'Admin criado com sucesso' },
        { command: 'dev:add_default_user', start_msg: 'Criando o Usuário padrão ...', end_msg: 'Usuário criado com sucesso' }
      ]

      tasks.each do |task|
        show_spinner(task[:start_msg], task[:end_msg]) { `rails #{task[:command]}` }
      end
    else
      puts 'Você não está no ambiente de desenvolvimento'
    end
  end

  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com.br',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com.br',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  private

  def show_spinner(start_msg, end_msg)
    spinner = TTY::Spinner.new("[:spinner] #{start_msg} ...")
    spinner.auto_spin
    if block_given?
      yield
      spinner.success("(#{end_msg})")
    else
      spinner.error('(ERRO: Não foi passado o bloco)')
    end
  end
end
