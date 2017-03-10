require "rails_helper"

RSpec.feature "Listing members" do
  
  before do
  
  @mladen1 = User.create(first_name: "John", last_name: "Doe", email: "john@email.com", password: "password")
  @mladen2 = User.create(first_name: "Bob", last_name: "Doe", email: "bob@email.com", password: "password")
    
  end
  
  scenario "shows list of registered members" do
    
    visit "/"
    
    expect(page).to have_content("List of members")
    expect(page).to have_content(@mladen1.full_name)
    expect(page).to have_content(@mladen2.full_name)
    
  end
  
end