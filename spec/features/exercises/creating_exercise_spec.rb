require "rails_helper"

RSpec.feature "Create exercise" do
  
  before do
    @mladen = User.create!(email: "mladen@email.com", password: "password")
    login_as(@mladen)
  end
  
  scenario "with valid input" do
    visit "/"
    
    click_link "My Lounge"
    click_link "New Workout"
    expect(page).to have_link("Back")
    
    fill_in "Duration", with: 70
    fill_in "Workout Details", with: "weight lifting"
    fill_in "Activity Date", with: "2017-07-26"
    click_button "Create Exercise"
    
    expect(page).to have_content("Exercise has been created")
    
    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@mladen, exercise))
    expect(exercise.user_id).to eq(@mladen.id) 
    
  end
  
end