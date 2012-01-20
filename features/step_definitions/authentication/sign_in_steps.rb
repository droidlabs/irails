Given /^I exist as #{capture_model}$/ do |model_name|
  @current_user = create_model(model_name)
end

Given /^I signed in as #{capture_model}$/ do |model_name|
  @current_user = create_model(model_name)
  visit path_to('the sign in page')
  
  fill_in 'Email', with: @current_user.email
  fill_in 'Password', with: @current_user.password
  click_button 'Sign in'
end

Given /^I am logged out$/ do
  visit path_to('the sign out page')
end

When /^I sign in with valid credentials$/ do
  visit path_to('the sign in page')
  
  fill_in 'Email', with: @current_user.email
  fill_in 'Password', with: @current_user.password
  click_button 'Sign in'
end

When /^I sign in with invalid credentials$/ do
  visit path_to('the sign in page')
  
  fill_in 'Email', with: @current_user.email
  fill_in 'Password', with: 'invalid password'
  click_button 'Sign in'
end

When /^I request new password$/ do
  visit path_to('the send password instructions page')
  
  fill_in 'Email', with: @current_user.email
  click_button 'Send me reset password instructions'
end

Then /^I should be signed in$/ do
  with_scope('the header') do
    page.should have_content('Logout')
  end
end

Then /^I should be signed out$/ do
  with_scope('the header') do
    page.should_not have_content('Logout')
  end
end

Then /^I should receive reset password instructions email$/ do
  emails("to: \"#{@current_user.email}\"").size.should > 0
  email("last email").body.should =~ /#{@current_user.full_name}/
  email("last email").body.should =~ /Change my password/
end