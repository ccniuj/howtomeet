json.array!(@admin_meetups) do |admin_meetup|
  json.extract! admin_meetup, :id
  json.url admin_meetup_url(admin_meetup, format: :json)
end
