# create a model
Given(/^#{capture_model} exists?(?: with #{capture_fields})?$/) do |name, fields|
  create_model(name, fields)
end

# create n models
Given(/^(\d+) #{capture_plural_factory} exist(?: with #{capture_fields})?$/) do |count, plural_factory, fields|
  count.to_i.times { create_model(plural_factory.singularize, fields) }
end

# create models from a table
Given(/^the following #{capture_plural_factory} exists?:?$/) do |plural_factory, table|
  create_models_from_table(plural_factory, table)
end

# find a model
Then(/^#{capture_model} should exist(?: with #{capture_fields})?$/) do |name, fields|
  find_model!(name, fields)
end

# not find a model
Then(/^#{capture_model} should not exist(?: with #{capture_fields})?$/) do |name, fields|
  find_model(name, fields).should be_nil
end

# find models with a table
Then(/^the following #{capture_plural_factory} should exists?:?$/) do |plural_factory, table|
  find_models_from_table(plural_factory, table).should_not be_any(&:nil?)
end