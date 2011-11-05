Then /^I should see "([^"]*)" error for "([^"]*)"$/ do |error_message, id|
  with_scope %Q{".input:has(##{id}) span.error"} do
    page.should have_content(error_message)
  end
end