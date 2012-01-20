When /^I submit registration form$/ do
  visit path_to("the sign up page")

  fill_in "Full name", with: "Chuck Norris"
  fill_in "Email", with: "chuck@example.com"
  fill_in "Password", with: "123456"
  fill_in "Password confirmation", with: "123456"
  click_button "Sign up"
end

When /^I submit registration form with invalid data$/ do
  visit path_to("the sign up page")
  
  fill_in "Full name", with: ""
  fill_in "Email", with: "invalid"
  fill_in "Password", with: "123456"
  fill_in "Password confirmation", with: "123456"
  click_button "Sign up"
end

Then /^I should receive registration confirmation email$/ do
  emails("to: \"chuck@example.com\"").size.should > 0
  email("last email").body.should =~ /Chuck Norris/
  email("last email").body.should =~ /Confirm my account/
end