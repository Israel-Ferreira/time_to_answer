class AdminsBackoffice::QuestionsController < AdminsBackofficeController

  before_action :set_question, only: %i[show update edit destroy]
  before_action :get_subjects, only: %i[new edit]

  def index
    @questions =  Question.all.page(params[:page])
  end
  
  def new
    @question = Question.new
  end
  
  def create
    @question =  Question.new(question_params)
    if @question.save
      redirect_to admins_backoffice_questions_path, notice: "Questão Criada com Sucesso"
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @question.update(question_params)
      redirect_to admins_backoffice_question_path, notice: "Questão Atualizada com Sucesso"
    else
      render :edit
    end
  end
  
  def show
  end
  
  def destroy
    if @question.destroy
      redirect_to admins_backoffice_questions_path, notice: "Questão Deletada com Sucesso"
    else
      render :index
    end
  end


  private 

  def set_question 
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:description, :subject_id)
  end

  def get_subjects
    @subjects = Subject.all.order(:description) 
  end
end
