class Api::V1::ProjectsController < Api::V1::BaseController

  before_action :set_nave
  before_action :set_project, only: %i[ show ]

  def index
    projects = @nave.projects.all
    render json:{ projects: projects }, status: :ok
  end

  def show
    render json: @project, status: :ok
  end

  private

  def set_nave
    @nave = Nave.find(params[:nave_id])
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
