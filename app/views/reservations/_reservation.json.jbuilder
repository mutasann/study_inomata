json.extract! reservation, :id, :reservation_id, :reservations_time, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
