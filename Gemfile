source 'http://rubygems.org'

gem 'rails', '3.2.12'
gem 'devise', '2.2.3'
gem 'slim-rails'

gem 'simple_form', '2.0.4'
gem 'configatron', '2.10.0'
gem 'default_value_for', '2.0.1'
gem 'paperclip', '3.4.0'
gem 'client_side_validations', '3.2.1'
gem 'client_side_validations-simple_form', '2.0.1'
gem 'kaminari', '0.14.1'
gem 'gritter', '1.0.3'
gem 'data_migrate', git: 'git://github.com/droidlabs/data-migrate.git'
gem 'navigation_link_to', '0.0.1'
gem 'roadie'

# background jobs
gem 'resque'
# gem 'sidekiq'

# serialization
gem 'yell', '1.2.3'
gem 'json', '1.7.7'

# admin panel
# TODO: enable after fixing issue loading with mongoid
# gem 'activeadmin-mongoid', git: 'git://github.com/simplybusiness/activeadmin-mongoid.git'
gem 'meta_search', '1.1.3'

# payments
# gem 'stripe', '1.7.9'

# assets
gem 'jquery-rails', '2.2.1'
gem 'sass-rails'
group :assets do
  gem 'bourbon'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.3.0'
  gem 'execjs', '1.4.0'
  gem 'therubyracer'
end

group :test, :development do
  # gem 'sqlite3', '1.3.7'
  gem 'launchy', '2.2.0'
  gem 'mongoid', '~> 3.0.0'
  gem 'bson_ext'
end

group :development do
  gem 'rails_best_practices', '1.13.4'
  gem 'capistrano', '2.14.2'
  gem 'capistrano-rbenv', '0.0.8'
  gem 'letter_opener', '0.0.2', git: 'git://github.com/droidlabs/letter_opener.git'
  gem 'quiet_assets', '1.0.1'
  gem 'thin', '1.5.0'
  gem 'bullet', '4.3.0'
  gem 'foreman', '0.61.0'
  gem 'pry-rails'
end

group :test do
  gem 'rspec-rails', '2.12.2'
  # gem 'mongoid-rspec', '>= 1.6.0'
  gem 'shoulda', '3.3.2'
  gem 'database_cleaner', '0.9.1'
  gem 'factory_girl_rails', '4.2.1'
  gem 'capybara', '2.0.2'
  gem 'email_spec', '1.4.0'
  gem 'simplecov', '0.7.1', require: false
  gem 'spork', '0.9.2'
  gem 'mocha', '0.13.2', require: 'mocha/setup'
  gem 'turnip'

  # javascript driver:
  gem 'poltergeist', '1.1.0', git: 'git://github.com/jonleighton/poltergeist.git'
  gem 'rack-contrib', '1.1.0'
end

group :staging, :production do
  gem 'mysql2', '0.3.11'
  gem 'exception_notification', '3.0.1'
  # gem 'airbrake', '3.1.6'
end
