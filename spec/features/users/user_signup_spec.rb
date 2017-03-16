require "rails_helper"

RSpec.feature "Sign up user" do
  
  scenario "with invalid credentials" do
    visit '/'
    click_link("Sign Up")
    
    fill_in "First name", with: ""
    fill_in "Last name", with: ""
    fill_in "Email", with: "mladen@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation" , with: "password"
    click_button "Sign up"
    
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    
  end
 
 
  scenario "with valid credentials" do
    visit '/'
    click_link("Sign Up")
    
    fill_in "First name", with: "Mladen"
    fill_in "Last name", with: "Marjanovic"
    fill_in "Email", with: "mladen@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation" , with: "password"
    click_button "Sign up"
    
    expect(page).to have_content("You have signed up successfully.")
    
    user = User.last
    room = user.room
    room_name = user.full_name.split.join(" ") 
    
    expect(room.name).to eq(room_name)
    
    visit "/"
    expect(page).to have_content("Mladen Marjanovic")
    
  end

end