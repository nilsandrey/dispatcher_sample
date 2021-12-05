json.data do
  json.array! @medications, partial: "medications/medication", as: :medication
end
