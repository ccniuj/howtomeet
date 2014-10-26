json.array!(@meetups) do |meetup|
  json.extract! meetup, :id
  json.url meetup_url(meetup, format: :json)
end
