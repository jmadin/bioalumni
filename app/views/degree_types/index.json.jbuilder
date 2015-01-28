json.array!(@degree_types) do |degree_type|
  json.extract! degree_type, :id, :degree_type_name, :degree_type_notes
  json.url degree_type_url(degree_type, format: :json)
end
