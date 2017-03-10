require "rails_helper"

RSpec.feature "Create exercise" do
  
  before do
    @mladen = User.create!(first_name: "Mladen", last_name: "Marjanovic", email: "mladen@email.com", password: "password")
    login_as(@mladen)
    
    visit "/"
    
    click_link "My Lounge"
    click_link "New Workout"
    expect(page).to have_link("Back")
  end
  
  scenario "with valid input" do
    fill_in "Duration", with: 70
    fill_in "Workout Details", with: "weight lifting"
    fill_in "Activity Date", with: 3.days.ago
    click_button "Create Exercise"
    
    expect(page).to have_content("Exercise has been created")
    
    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@mladen, exercise))
    expect(exercise.user_id).to eq(@mladen.id) 
    
  end
  
  scenario "with valid input" do
    fill_in "Duration", with: ""
    fill_in "Workout Details", with: ""
    fill_in "Activity Date", with: ""
    click_button "Create Exercise"
    
    expect(page).to have_content("Exercise has not been created")
    expect(page).to have_content("Duration in min is not a number")
    expect(page).to have_content("Workout details can't be blank")
    expect(page).to have_content("Activity date can't be blank")
  end
  
end