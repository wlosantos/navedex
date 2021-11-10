class Api::V1::ProjectsController < Api::V1::BaseController

  before_action :set_nave

  def index
    projects = @nave.projects.all
    render json:{ projects: projects }, status: :ok
  end

  private

  def set_nave
    @nave = Nave.find(params[:nave_id])
  end
end
