class Api::V1::NavesController < Api::V1::BaseController

  before_action :set_nave, only: %i[ show update destroy ]

  def index
    naves = current_api_user.naves.list_naves
    render json: naves, status: :ok
  end

  def show
    render json: @nave.description_nave, status: :ok
  end

  def create
    nave = current_api_user.naves.build nave_params

    if nave.save
      render json: nave.store_nave, status: :created
    else
      render json: { errors: nave.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    if @nave.update nave_params
      render json: @nave.store_nave, status: :ok
    else
      render json: { errors: @nave.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @nave.destroy
      head 204
    else
      head 404
    end
  end

  def projects
    projects = Projects.all
    render json: projects
  end

  private

  def set_nave
    @nave = current_api_user.naves.find(params[:id])
  end

  def nave_params
    params.require(:nave).permit( :name,
                                  :birthdate,
                                  :admision_job,
                                  :job_role)
  end
end
