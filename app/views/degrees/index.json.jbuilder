json.array!(@degrees) do |degree|
  json.extract! degree, :id, :user_id, :alum_id, :degree_name, :graduation_year, :thesis_title, :degree_notes
  json.url degree_url(degree, format: :json)
end
