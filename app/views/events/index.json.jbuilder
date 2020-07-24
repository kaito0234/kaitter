json.array!(@events) do |event|
  json.extract! event, :id, :title, :memo, :palce, :user_id, :color, :allday
  json.start event.start_date
  json.end event.end_date
  json.url event_url(event, format: :html)

  # json.color
  if event.start_date > Time.now
    json.color "#ff0000"
  else
    json.color ""
  end
end