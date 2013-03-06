# Create default users
p 'Create user: user@example.com - password'
User.create!(
  full_name: 'Example User',
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password'
).confirm!

p 'Create admin user: admin@example.com - password'
AdminUser.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password'
)