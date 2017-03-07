require "rails_helper"

RSpec.feature "User sign in" do
  
  before do 
      @mladen = User.create!(email: "mladen@email.com", password: "password")
      
    end
  
  scenario "with valid credentials" do
    
    visit "/"
    click_link("Sign in")
    
    fill_in "Email", with: "mladen@email.com"
    fill_in "Password", with: "password"
    click_button("Log in")
    
    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@mladen.email}")
    expect(page).not_to have_link("Sign Up")
    expect(page).not_to have_link("Sign in")
    
  end
  
end