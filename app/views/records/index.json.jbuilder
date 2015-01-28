json.array!(@records) do |record|
  json.extract! record, :id, :user_id, :alum_id, :career_id, :work_link, :email, :phone, :record_notes
  json.url record_url(record, format: :json)
end
