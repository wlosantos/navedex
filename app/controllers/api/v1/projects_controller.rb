class Api::V1::ProjectsController < Api::V1::BaseController

  before_action :set_nave
  before_action :set_project, only: %i[ show update destroy ]

  def index
    projects = Project.all
    render json: projects, status: :ok
  end

  def show
    render json: @project, status: :ok
  end

  def create
    project = @nave.projects.build(project_params)

    if project.save
      render json: project, status: :created
    else
      render json: {errors: project.errors.full_messages }, status: :unprocessable_entity 
    end
  end

  def update
    if @project.update(project_params)
      render json: @project, status: :ok
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def set_nave
    @nave = Nave.find(params[:nave_id])
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
