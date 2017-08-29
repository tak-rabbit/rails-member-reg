json.extract! member, :id, :name, :email, :password_digest, :created_at, :updated_at
json.url member_url(member, format: :json)
