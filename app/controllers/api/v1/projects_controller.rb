class Api::V1::ProjectsController < Api::V1::BaseController

  before_action :set_project, only: %i[ show update destroy ]

  def index
    projects = Project.total_user_projects(current_api_user)
    render json: projects, status: :ok
  end

  def show
    render json: @project.project_with_nave(current_api_user.id), status: :ok
  rescue
    head 204
  end

  def create
    @nave = Nave.find(params[:nave_id])
    project = @nave.projects.build(project_params)

    if project.save
      project_store = { id: project.id, name: project.name }
      render json: project_store, status: :created
    else
      render json: {errors: project.errors.full_messages }, status: :unprocessable_entity 
    end
  end

  def update
    if @project.update(project_params)
      project_store = { id: @project.id, name: @project.name }

      render json: project_store, status: :ok
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # def destroy
  #   if @project.destroy
  #     head :ok
  #   else
  #     head :unprocessable_entity
  #   end
  # end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
