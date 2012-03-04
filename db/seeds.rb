# Create default users
User.create!(
  full_name: 'Example User',
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password'
).confirm!

AdminUser.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password'
)