require "rails_helper"

RSpec.feature "Sign up user" do
=begin   
  scenario "with invalid credentials" do
    visit '/'
    click_link("Sign Up")
    
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password Confirmation" , with: ""
    click_button "Sign Up"
    
    expect(page).to have_content("You have not signed up successfully.")
    
  end
=end  
 
  scenario "with valid credentials" do
    visit '/'
    click_link("Sign Up")
    
    fill_in "Email", with: "mladen@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation" , with: "password"
    click_button "Sign up"
    
    expect(page).to have_content("You have signed up successfully.")
    
  end

end