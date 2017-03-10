require "rails_helper"

RSpec.feature "Editing exercise" do
  
  before do
    @mladen = User.create!(first_name: "Mladen", last_name: "Marjanovic", email: "mladen@email.com", password: "password")
    
    @e1 = @mladen.exercises.create!(duration_in_min: 50, workout: "running", workout_date: Date.today)
    
    login_as(@mladen)
  end
  
  scenario "with valid input" do
    visit "/"
    
    click_link "My Lounge"
    
    path = "/users/#{@mladen.id}/exercises/#{@e1.id}/edit"
    link = "a[href=\'#{path}\']"
    
    find(link).click
    
    fill_in "Duration", with: 45
    click_button "Update Exercise"
    
    expect(page).to have_content("Exercise has been updated")
    expect(page).to have_content(45)
    expect(page).not_to have_content(48)
  end

  
end