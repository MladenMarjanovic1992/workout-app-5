require "rails_helper"

RSpec.feature "Searching for users" do
  
  before do
    
    @mladen1 = User.create(first_name: "John", last_name: "Doe", email: "john@email.com", password: "password")
    @mladen2 = User.create(first_name: "Bob", last_name: "Doe", email: "bob@email.com", password: "password")
    
  end
  
  scenario "with exesting name shows all users with that name" do
    
    visit "/"
    
    fill_in "search_name", with: "Doe"
    click_button "Search"
    
    expect(page).to have_content(@mladen1.full_name)
    expect(page).to have_content(@mladen2.full_name)
    expect(current_path).to eq("/dashboards/search")
    
  end
  
end