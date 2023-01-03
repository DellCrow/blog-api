json.extract! like, :id, :likeable_type, :likeable_id, :user_id
json.user do
  json.partial! "users/user", user: like.user, token: nil
end