module AuthenticationSteps
  def sign_in_with(email, password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign in'
  end

  step "I signed in as user" do
    @current_user = FactoryGirl.create(:confirmed_user)
    sign_in_with(@current_user.email, @current_user.password)
  end

  step "I exist as a user" do
    @current_user = FactoryGirl.create(:confirmed_user)
  end

  step "I sign in with valid credentials" do
    sign_in_with(@current_user.email, @current_user.password)
  end

  step "I sign in with invalid credentials" do
    sign_in_with(@current_user.email, 'invalid')
  end

  step "I sign out" do
    visit '/'
    click_link 'Logout'
  end

  step 'I should be signed in' do
    within ".site-navigation" do
      page.should have_content "Logout"
    end
  end

  step 'I should be signed out' do
    within ".site-navigation" do
      page.should_not have_content "Logout"
    end
  end
end