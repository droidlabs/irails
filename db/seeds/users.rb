def create_user(attrs = {})
  attrs[:password_confirmation] = attrs[:password]
  user = User.new(attrs)
  user.skip_confirmation!
  user.save
end

log "create Example user user@example.com : password" do
  create_user(
    full_name: "Example User",
    email: "user@example.com",
    password: "password"
  )
end

log "create Bruce Lee user bruce@lee.com : password" do
  create_user(
    full_name: "Bruce Lee",
    email: "bruce@lee.com",
    password: "password"
  )
end

log "create admin user admin@example.com : password" do
  AdminUser.create(
    email: "admin@example.com",
    password: "password",
    password_confirmation: "password"
  )
end