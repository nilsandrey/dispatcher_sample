json.data do
  json.extract! @drone, :id, :serial_number, :model, :weight_limit, :battery, :state
end
