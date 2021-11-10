class Api::V1::NavesController < Api::V1::BaseController

  before_action :set_nave, only: %i[ show ]

  def index
    naves = current_api_user.naves.all
    render json: { naves: naves }, status: :ok
  end

  def show
    render json: @nave, status: :ok
  end

  def create
    nave = current_api_user.naves.build nave_params

    if nave.save
      render json: nave, status: :created
    else
      render json: { errors: nave.errors.full_messages}, status: :unprocessable_entity
    end
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
