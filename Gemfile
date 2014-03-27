source 'http://rubygems.org'

gem 'rails', '4.1.0.rc2'
gem 'slim-rails', '~> 2.1.0'
gem 'paperclip', '~> 4.1.0'
gem 'devise', '~> 3.2.4'
gem 'configatron', '2.13.0'
gem 'navigation_link_to', '0.0.2'
gem 'cyrax', '0.7.3'

gem 'simple_form', '3.0.0'
gem 'activeadmin', github: "gregbell/active_admin"

# emails styles
gem 'roadie', '2.4.3'

# assets
gem 'sass-rails', '~> 4.0.2'
gem 'uglifier', '~> 2.4.0'
gem 'coffee-rails', '~> 4.0.1'
gem 'therubyracer', platforms: :ruby, require: 'v8'
gem 'droidcss'
gem 'jquery-rails'

group :test, :development do
  gem 'sqlite3'
end

group :development do
  gem 'capistrano', '2.15.5', require: false
  gem 'letter_opener'
  gem 'quiet_assets', '1.0.2'
  gem 'thin', '1.6.0'
  gem 'pry-rails'
  gem 'spring'
  
  # gem 'capistrano-rbenv', require: false
end

group :test do
  gem "minitest" # temporary fix to avoid warnings
  gem 'rspec-rails', '~> 2.14.1'
  gem "spring-commands-rspec"
  gem 'shoulda', '3.5.0'
  gem 'database_cleaner', '1.2.0'
  gem 'factory_girl_rails', '4.2.1'
  gem 'capybara', '2.2.0'
  gem 'email_spec', '1.5.0'
  gem 'mocha', '1.0.0', require: 'mocha/setup'
  gem 'turnip', '1.2.1'
end

group :production, :staging do
  gem 'mysql2', '0.3.15'
  # gem 'rollbar', require: 'rollbar/rails'
end

# temporary gems
gem 'polyamorous', github: 'activerecord-hackery/polyamorous'