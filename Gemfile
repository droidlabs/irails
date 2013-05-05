source 'http://rubygems.org'

gem 'rails', '3.2.13'
gem 'devise', '2.2.3'
gem 'slim-rails'

gem 'simple_form', '2.0.4'
gem 'configatron', '2.10.0'
gem 'paperclip', '3.4.1'
gem 'client_side_validations', '3.2.5'
gem 'client_side_validations-simple_form', '2.0.1'
gem 'gritter', '1.0.3'
gem 'data_migrate', git: 'git://github.com/droidlabs/data-migrate.git'
gem 'navigation_link_to', '0.0.1'
gem 'roadie'

# background jobs
gem 'resque'
# gem 'sidekiq'

# serialization
gem 'yell', '1.3.0'
gem 'json', '1.7.7'

# admin panel
gem 'activeadmin', '0.5.1'
gem 'meta_search', '1.1.3'

# assets
gem 'jquery-rails', '2.2.1'
gem 'sass-rails', '3.2.6'
group :assets do
  gem 'bourbon', '3.1.6'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.3.0'
  gem 'execjs', '1.4.0'
  gem 'therubyracer'
end

group :test, :development do
  gem 'sqlite3', '1.3.7'
  gem 'launchy', '2.2.0'
end

group :development do
  gem 'rails_best_practices', '1.13.4', require: false
  gem 'capistrano', '2.15.4', require: false
  gem 'capistrano-rbenv', '0.0.10', require: false
  gem 'letter_opener', '0.0.2', git: 'git://github.com/droidlabs/letter_opener.git'
  gem 'quiet_assets', '1.0.2'
  gem 'thin', '1.5.0'
  gem 'bullet', '4.6.0'
  gem 'pry-rails'
end

group :test do
  gem 'rspec-rails', '2.13.0'
  gem 'shoulda', '3.3.2'
  gem 'database_cleaner', '0.9.1'
  gem 'factory_girl_rails', '4.2.1'
  gem 'capybara', '2.0.2'
  gem 'email_spec', '1.4.0'
  gem 'simplecov', '0.7.1', require: false
  gem 'spork', '0.9.2'
  gem 'mocha', '0.13.2', require: 'mocha/setup'
  gem 'turnip'
  gem 'rack-contrib', '1.1.0'
end

group :staging, :production do
  gem 'mysql2', '0.3.11'
  gem 'exception_notification', '3.0.1'
  # gem 'airbrake', '3.1.6'
end
