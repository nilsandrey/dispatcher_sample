class DroneSetBatteryDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :drones, :battery, 100
  end
end
