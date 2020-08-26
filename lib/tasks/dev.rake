# frozen_string_literal: true

namespace :dev do
  DEFAULT_PASSWORD = 123_456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc 'TODO'
  task setup: :environment do
    if Rails.env.development?
      tasks = [
        { command: 'db:drop', start_msg: 'Apagando o banco de dados', end_msg: 'Banco de dados apagado com sucesso' },
        { command: 'db:create', start_msg: 'Criando o banco de dados', end_msg: 'Banco de dados criado com sucesso' },
        { command: 'db:migrate', start_msg: 'Migrando o BD', end_msg: 'Migração realizada com sucesso' },
        { command: 'dev:add_default_admin', start_msg: 'Criando o Admin ...', end_msg: 'Admin criado com sucesso' },
        { command: 'dev:add_extra_admins', start_msg: 'Adicionando Administradores extras ...', end_msg: 'Admins extras adicionados com sucesso' },
        { command: 'dev:add_default_user', start_msg: 'Criando o Usuário padrão ...', end_msg: 'Usuário criado com sucesso' },
        { command: 'dev:add_subjects', start_msg: 'Cadastrando os Assuntos Padrões...', end_msg: 'Assuntos Padrões cadastrados com sucesso!' },
        { command: 'dev:add_questions_and_answers', start_msg: 'Cadastrando Questões e Respostas...', end_msg: 'Questões e Respostas cadastradas com sucesso!' }
      ]

      tasks.each do |task|
        show_spinner(task[:start_msg], task[:end_msg]) { `rails #{task[:command]}` }
      end
    else
      puts 'Você não está no ambiente de desenvolvimento'
    end
  end

  desc 'Adiciona o administrador padrão'
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com.br',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc 'Adiciona administradores extras'
  task add_extra_admins: :environment do
    10.times do
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc 'Adiciona o usuário padrão'
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com.br',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc 'Adiciona os assuntos padrões '
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end

  desc 'Adiciona Questões e Respostas'
  task add_questions_and_answers: :environment do
    Subject.all.each do |subject|
      rand(5..10).times do
        params = create_question_params(subject)

        add_answers(params[:question][:answers_attributes])
        elect_true_answer(params[:question][:answers_attributes])

        Question.create!(params[:question])
      end
    end
  end

  desc 'Reseta os contadores dos assuntos'
  task reset_subject_counter: :environment do
    show_spinner("Resetando contador dos assuntos...", "Contadores Atualizados") do
      Subject.find_each do |subject|
        Subject.reset_counters(subject.id, :questions)
      end
    end
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

  def create_question_params(subject)
    {
      question: {
        description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
        subject: subject,
        answers_attributes: []
      }
    }
  end


  def create_answer_params
    {description: Faker::Lorem.sentence, correct: false}
  end

  def add_answers(arr_answers)
    rand(2..5).times do
      arr_answers.push(create_answer_params)
    end
  end

  def elect_true_answer(arr_answers)
    selected_index = rand(arr_answers.size)
    arr_answers[selected_index] = { description: Faker::Lorem.sentence, correct: true }
  end
end
