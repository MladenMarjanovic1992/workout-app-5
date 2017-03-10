require "rails_helper"

RSpec.feature "User sign out" do
  
  before do
    @mladen = User.create!(first_name: "Mladen", last_name: "Marjanovic", email: "mladen@email.com", password: "password")
    visit '/'
    click_link "Sign in"
    fill_in "Email", with: @mladen.email
    fill_in "Password",  with: @mladen.password
    click_button "Log in"
  end
  
  scenario "user signs out" do
    
    visit "/"
    click_link "Sign out"
    
    expect(page).to have_content("Signed out successfully")
    
  end
  
end