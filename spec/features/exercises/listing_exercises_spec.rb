require "rails_helper"

RSpec.feature "Listing Exercises" do
  
  before do
    @mladen = User.create(email: "mladen@email.com", password: "password")
    login_as(@mladen)
    
    @e1 = @mladen.exercises.new(duration_in_min: 50, workout: "running", workout_date: Date.today)
    @e2 = @mladen.exercises.new(duration_in_min: 60, workout: "cardio", workout_date: 2.days.ago)
  end
  
  scenario "shows user workouts for last 7 days" do
    
    visit "/"
    click_link "My Lounge"
    
    expect(page).to have_content(@e1.duration_in_min)
    expect(page).to have_content(@e1.workout)
    expect(page).to have_content(@e1.workout_date)
    
    expect(page).to have_content(@e2.duration_in_min)
    expect(page).to have_content(@e2.workout)
    expect(page).to have_content(@e2.workout_date)
    
  end
  
  scenario "shows no exercises if there are none" do
    
    @mladen.exercises.delete_all
    
    visit "/"
    click_link "My Lounge"
    
    expect(page).to have_content("No Workouts yet")
    
  end
  
end