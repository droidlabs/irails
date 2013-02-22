require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require 'simplecov'
  SimpleCov.start 'rails'

  require 'rails/application'
  Spork.trap_method(Rails::Application, :reload_routes!)
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
  Spork.trap_method(Rails::Application, :eager_load!)
  require File.expand_path("../../config/environment", __FILE__)
  Rails.application.railties.all { |r| r.eager_load! }
  require 'rspec/rails'
  require "email_spec"
  require "rails/mongoid"
  Spork.trap_class_method(Rails::Mongoid, :load_models)

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)
    config.include(Rails.application.routes.url_helpers)
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :mocha

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # require step definitions
    Dir[Rails.root.join("spec/support/step_definitions/*.rb")].each do |file|
      begin
        require(file)
        module_name = file.to_s.split('/').last.split('.').first.camelize
        config.include module_name.constantize
      rescue
      end
    end
  end
end

Spork.each_run do
  FactoryGirl.reload

  DatabaseCleaner[:mongoid].strategy = :truncation
  DatabaseCleaner[:mongoid].clean
end