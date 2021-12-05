class CargosController < ApplicationController
  before_action :set_cargo, only: %i[ show update destroy ]

  # GET /cargos
  # GET /cargos.json
  def index
    @cargos = Cargo.all
  end

  # GET /cargos/1
  # GET /cargos/1.json
  def show
  end

  # POST /cargos
  # POST /cargos.json
  def create
    @cargo = Cargo.new(cargo_params)

    if @cargo.save
      render :show, status: :created, location: @cargo
    else
      render json: @cargo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cargos/1
  # PATCH/PUT /cargos/1.json
  def update
    if @cargo.update(cargo_params)
      render :show, status: :ok, location: @cargo
    else
      render json: @cargo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cargos/1
  # DELETE /cargos/1.json
  def destroy
    @cargo.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cargo
      @cargo = Cargo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cargo_params
      params.require(:cargo).permit(:active, :drone_id)
    end
end
