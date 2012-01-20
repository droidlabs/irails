ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true

Before do
  ActionMailer::Base.deliveries.clear
end

# Clear the deliveries array, useful if your background sends email that you want to ignore
Given(/^all emails? (?:have|has) been delivered$/) do
  ActionMailer::Base.deliveries.clear
end

Given(/^(\d)+ emails? should be delivered$/) do |count|
  emails.size.should == count.to_i
end

Then(/^(\d)+ emails? should be delivered with #{capture_fields}$/) do |count, fields|
  emails(fields).size.should == count.to_i
end

When(/^(?:I|they) follow "([^"]*?)" in #{capture_email}$/) do |link, email_ref|
  visit_in_email(email(email_ref), link)
end

When(/^(?:I|they) click the first link in #{capture_email}$/) do |email_ref|
  click_first_link_in_email(email(email_ref))
end

Then(/^(\d)+ emails? should be delivered to (.*)$/) do |count, to|
  emails("to: \"#{email_for(to)}\"").size.should == count.to_i
end

Then(/^show me the emails?$/) do
   save_and_open_emails
end