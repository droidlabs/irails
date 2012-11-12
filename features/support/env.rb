require 'simplecov'
SimpleCov.start 'rails'

require 'database_cleaner'
require 'cucumber/rails'
require 'capybara/cucumber'
require 'capybara/session'
require 'capybara/poltergeist'

Capybara.default_selector = :css
Capybara.javascript_driver = :poltergeist

ActionController::Base.allow_rescue = false
DatabaseCleaner.strategy = :truncation
