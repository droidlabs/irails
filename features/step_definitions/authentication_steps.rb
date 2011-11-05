Given /^I am an authenticated user$/ do
  @current_user = Factory(:confirmed_user, id: 1, email: "me@example.com", password: 123456)
  visit path_to('the sign in page')
  fill_in 'Email', with: 'me@example.com'
  fill_in 'Password', with: '123456'
  click_button 'Sign in'
end

Given /^I am logged out$/ do
  visit path_to('the sign out page')
end

Then /^I should be signed in$/ do
  with_scope('the header') do
    page.should have_content('Logout')
  end
end
