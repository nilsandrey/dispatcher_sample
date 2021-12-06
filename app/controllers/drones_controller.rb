class DronesController < ApplicationController
  # Before action define parameters...
  before_action :set_drone, only: %i[destroy check_battery ready go load show cancel]
  before_action :set_filter, only: [:index]
  before_action :set_load_params, only: [:load]

  def index
    @drones = nil
    @drones = Drone.all unless @filter
    @drones = Drone.idle_state if @filter == 'idle'
    @drones = Drone.loading_state if @filter == 'loading'

    render_error(:bad_request, StandardError.new('Bad request')) unless @drones
    render_entities(@drones) if @drones
  end

  ##
  # Registering a drone
  def create
    @drone = Drone.new(translated_drone_params)
    if @drone.save
      render_entities(@drone)
    else
      render_error(:unprocessable_entity, StandardError.new('Invalid parameters'), @drone.errors)
    end
  end

  def destroy
    if @drone.destroy
      render json: {}, status: :no_content # https://jsonapi.org/format/#crud-deleting-responses-204
    else
      render_error(:unprocessable_entity, StandardError.new('Can\'t unregister drone'), @drone.errors)
    end
  end

  def check_battery
    render json: {
      'type': 'Drone',
      'id': @drone.id,
      battery_level: @drone.battery,
    }, statuts: :ok
  end

  def ready
    protect_record_not_saved do
      @drone.loaded_state!
      render_entities(@drone)
    end
  end

  def go
    protect_record_not_saved do
      @drone.delivering_state!
      render_entities(@drone)
    end
  end

  def load
    @drone.load(@medication, @count)
  rescue StandardError => e
    render_error(:unprocessable_entity, e)
  end

  def show; end

  def cancel
    protect_record_not_saved do
      @drone.cancel!
    end
  end

  private

  def set_drone
    protect_not_found {@drone = Drone.find(params[:id])}
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

  def set_load_params
    # Receive parameter cargo with this structure:
    # {"medication": "DDDFDFSDF", "count": "1"}
    protect_parameter_missing do
      protect_not_found { @medication = Medication.find_by_code(params[:medication]) } # Translate code to medication
      @count = params[:count]
    end
  end
end
