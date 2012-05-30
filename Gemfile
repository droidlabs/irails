source 'http://rubygems.org'

gem 'rails', '3.2.3'
gem 'devise', '2.0.4'
gem 'slim-rails', '1.0.3'

gem 'simple_form', '1.5.2'
gem 'configatron', '2.8.4'
gem 'default_value_for', '1.0.7'
gem 'paperclip', '2.7.0'
gem 'client_side_validations', '3.2.0.beta.3'
gem 'client_side_validations-simple_form', '1.5.0.beta.3'
gem 'kaminari', '0.13.0'
gem 'gritter', '1.0.1'
gem 'seedbank', '0.0.8'

# admin panel
gem 'activeadmin', '0.4.2'
gem 'meta_search', '1.1.2'

# payments
gem 'stripe', '1.6.0'

# assets
gem 'jquery-rails', '2.0.2'
gem 'sass-rails', '3.2.4'
group :assets do
  gem 'bourbon', '1.2.0'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.1'
  gem 'execjs', '1.2.13'
end

group :test, :development do
  gem 'sqlite3', '1.3.6'
  gem 'launchy', '2.0.5'
end

group :development do
  gem 'rails_best_practices', '1.9.1'
  gem 'capistrano', '2.11.2'
  gem 'letter_opener', '0.0.2', git: 'git://github.com/droidlabs/letter_opener.git'
  gem 'quiet_assets', '1.0.1'
end

group :test do
  gem 'sqlite3', '1.3.6'
  gem 'rspec-rails', '2.10.1'
  gem 'cucumber-rails', '1.3.0'
  gem 'shoulda', '2.11.3'
  gem 'database_cleaner', '0.7.1'
  gem 'factory_girl_rails', '3.2.0'
  gem 'capybara', '1.1.2'
  gem 'pickle', '0.4.10'
  gem 'email_spec', '1.2.1'
  gem 'simplecov', '0.5.4', require: false
  gem 'spork', '0.9.0'
  gem 'mocha', '0.11.4'
end

group :staging, :production do
  gem 'mysql2', '0.3.11'
end
