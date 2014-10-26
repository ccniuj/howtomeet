json.array!(@admin_notes) do |admin_note|
  json.extract! admin_note, :id
  json.url admin_note_url(admin_note, format: :json)
end
