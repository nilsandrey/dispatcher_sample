class DroneSetMoreDefaults < ActiveRecord::Migration[6.1]
  def change
    # Set state default to idle
    change_column_default :drones, :state, 0 
  end
end
