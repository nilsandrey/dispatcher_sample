json.data do
  json.extract! @drone, :id, :serial_number, :model, :weight_limit, :battery, :state
  if @drone.active_cargo.present?
    json.extract! @drone.active_cargo, :active
    json.supplies do
      json.array! @drone.active_cargo.supplies do |supply|
        json.count           supply.count
        json.extract!        supply.medication, :code, :name, :weight, :image
      end
    end
  end
end
