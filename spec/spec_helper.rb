ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require "email_spec"
require 'shoulda/matchers'
require 'database_cleaner'

RSpec.configure do |config|
  config.include(FactoryGirl::Syntax::Methods)
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
  # config.use_transactional_fixtures = false
  # config.infer_base_class_for_anonymous_controllers = false
  # config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

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
