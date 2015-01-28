json.array!(@alums) do |alum|
  json.extract! alum, :id, :user_id, :first_name, :middle_name, :last_name, :sex, :dob, :mq_id, :alum_notes
  json.url alum_url(alum, format: :json)
end
