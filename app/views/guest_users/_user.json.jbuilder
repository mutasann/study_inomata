json.extract! user, :id, :name, :login_id, :password_digest, :user_type, :created_at, :updated_at
json.url user_url(user, format: :json)
