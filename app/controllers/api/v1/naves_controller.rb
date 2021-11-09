class Api::V1::NavesController < Api::V1::BaseController

  def index
    naves = Nave.all
    render json: {naves: naves, status: 'success'}, status: :ok
  end
end
