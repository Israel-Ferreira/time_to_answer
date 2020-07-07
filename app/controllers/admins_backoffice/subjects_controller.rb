# frozen_string_literal: true

class AdminsBackoffice::SubjectsController < AdminsBackofficeController
  before_action :set_subject, only: %i[show edit update destroy]

  def index
    @subjects = Subject.all.page(params[:page])
  end

  def new
    @subject =  Subject.new
  end

  def show; end

  def edit; end

  def create
    @subject =  Subject.new(subject_params)
    if @subject.save
      back_to_subjects_list('Assunto/Área criado com sucesso')
    else
      flash[:error] = @subject.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @subject.update(subject_params)
      back_to_subjects_list('Assunto/Área atualizado com sucesso')
    else
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      back_to_subjects_list('Assunto excluido com sucesso')
    else
      render :index
    end
  end

  private

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    params.require(:subject).permit(:description)
  end

  def back_to_subjects_list(notice)
    back_resource_index(admins_backoffice_subjects_path, notice)
  end
end
