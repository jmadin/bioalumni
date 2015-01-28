json.array!(@careers) do |career|
  json.extract! career, :id, :user_id, :career_name, :career_type, :career_system, :career_notes
  json.url career_url(career, format: :json)
end
