class DronesController < ApplicationController
  # Before action define parameters...
  before_action :set_drone, only: [:destroy, :check_battery]
  before_action :set_filter, only: [:index]

  def index
    @drones = nil
    @drones = Drone.all unless @filter
    @drones = Drone.idle_state if @filter == "idle"
    @drones = Drone.loading_state if @filter == "loading"

    render_error(:bad_request, StandardError.new("Bad request")) unless @drones
    render_entities(@drones) if @drones
  end

  def create
    @drone = Drone.new(translated_drone_params)
    if @drone.save
      render_entities(@drone)
    else
      render_error(:unprocessable_entity, StandardError.new("Invalid parameters"), @drone.errors)
    end
  end

  def destroy
    if @drone.destroy
      render json: {}, status: :no_content # https://jsonapi.org/format/#crud-deleting-responses-204
    else
      render_error(:unprocessable_entity, StandardError.new('Can\'t delete drone'), @drone.errors)
    end
  end

  def check_battery
    render json: {
      'type': "Drone",
      'id': @drone.id,
      battery_level: @drone.battery,
    }, statuts: :ok
  end

  private

  def set_drone
    protect_not_found { @drone = Drone.find(params[:id]) }
  end

  def drone_params
    protect_parameter_missing {
      params.require(:drone).permit(%i[serial_number model weight_limit])
    }
  end

  def translated_drone_params
    current_params = drone_params
    current_params[:model] = Drone.models[current_params[:model]] if current_params[:model].class == String
    current_params
  end

  def set_filter
    @filter = params[:filter]
  end
end
