source 'http://rubygems.org'

gem 'rails', '4.0.0'
gem 'slim-rails', '2.0.1'
gem 'paperclip', '3.5.1'
gem 'devise', '3.1.0'
gem 'configatron', '2.13.0'
gem 'navigation_link_to', '0.0.1'
gem 'cyrax', '0.4.0.beta2'

gem 'simple_form', '3.0.0'
gem 'activeadmin', github: "gregbell/active_admin"

# emails styles
gem 'roadie'

# assets
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', platforms: :ruby
gem 'droidcss'
gem 'jquery-rails'
gem 'jquery-turbolinks', '2.0.1'
gem 'turbolinks'

group :test, :development do
  gem 'sqlite3'
end

group :development do
  gem 'capistrano', '2.15.5', require: false
  gem 'letter_opener'
  gem 'quiet_assets', '1.0.2'
  gem 'thin', '1.5.1'
  gem 'pry-rails'

  # gem 'capistrano-rbenv', require: false
  # gem 'zeus'
end

group :test do
  gem 'rspec-rails', '~> 2.14.0'
  gem 'shoulda', '3.5.0'
  gem 'database_cleaner', '1.0.1'
  gem 'factory_girl_rails', '4.2.1'
  gem 'capybara', '2.1.0'
  gem 'email_spec', '1.4.0'
  gem 'mocha', '0.14.0', require: 'mocha/setup'
  gem 'turnip'
end

group :production, :staging do
  gem 'mysql2', '0.3.13'
  # gem 'rollbar', require: 'rollbar/rails'
end