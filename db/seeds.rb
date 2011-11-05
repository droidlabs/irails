# Create a default admin user
AdminUser.create!(
  :email => 'admin@example.com', 
  :password => 'password', 
  :password_confirmation => 'password'
)
