class Api::V1::NavesController < Api::V1::BaseController

  before_action :set_nave, only: %i[ show ]

  def index
    naves = current_api_user.naves.all
    render json: {naves: naves, message: 'success' }, status: :ok
  end

  def show
    render json: @nave, status: :ok
  end

  private

  def set_nave
    @nave = current_api_user.naves.find(params[:id])
  end
end
