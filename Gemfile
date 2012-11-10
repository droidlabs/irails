source 'http://rubygems.org'

gem 'rails', '3.2.8'
gem 'devise', '2.1.2'
gem 'slim-rails', '1.0.3'

gem 'simple_form', '2.0.4'
gem 'configatron', '2.9.1'
gem 'default_value_for', '2.0.1'
gem 'paperclip', '3.3.1'
gem 'client_side_validations', '3.2.1'
gem 'client_side_validations-simple_form', '2.0.0'
gem 'kaminari', '0.14.1'
gem 'gritter', '1.0.2'
gem 'seedbank', '0.2.0'
gem 'data_migrate', git: 'git://github.com/droidlabs/data-migrate.git'
gem 'navigation_link_to', '0.0.1'

# serialization
gem 'yell', '1.2.0'
gem 'json', '1.7.5'

# admin panel
gem 'activeadmin', '0.5.0'
gem 'meta_search', '1.1.3'

# payments
gem 'stripe', '1.7.6'

# assets
gem 'jquery-rails', '2.1.3'
gem 'sass-rails', '3.2.5'
group :assets do
  gem 'bourbon', '2.1.2'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.3.0'
  gem 'execjs', '1.4.0'
end

group :test, :development do
  gem 'sqlite3', '1.3.6'
  gem 'launchy', '2.1.2'
end

group :development do
  gem 'rails_best_practices', '1.12.0'
  gem 'capistrano', '2.13.5'
  gem 'capistrano-rbenv', '0.0.6'
  gem 'letter_opener', '0.0.2', git: 'git://github.com/droidlabs/letter_opener.git'
  gem 'quiet_assets', '1.0.1'
  gem 'thin', '1.5.0'
  gem 'bullet', '4.2.0'
end

group :test do
  gem 'rspec-rails', '2.11.4'
  gem 'cucumber-rails', '1.3.0'
  gem 'shoulda', '3.3.2'
  gem 'database_cleaner', '0.9.1'
  gem 'factory_girl_rails', '4.1.0'
  gem 'capybara', '1.1.3'
  gem 'pickle', '0.4.11'
  gem 'email_spec', '1.4.0'
  gem 'simplecov', '0.7.1', require: false
  gem 'spork', '0.9.0'
  gem 'mocha', '0.12.7'
end

group :staging, :production do
  gem 'mysql2', '0.3.11'
  gem 'exception_notification', '3.0.0'
end
