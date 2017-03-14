require "rails_helper"

RSpec.feature "Listing Exercises" do
  
  before do
    @mladen = User.create!(first_name: "Mladen", last_name: "Marjanovic", email: "mladen@email.com", password: "password")
    @sarah = User.create!(first_name: "Sarah", last_name: "Johnson", email: "sarah@email.com", password: "password")    
    login_as(@mladen)
    
    
    
    @e1 = @mladen.exercises.new(duration_in_min: 50, workout: "running", workout_date: Date.today)
    @e2 = @mladen.exercises.new(duration_in_min: 60, workout: "cardio", workout_date: 2.days.ago)
    
    @following = Friendship.create(user: @mladen, friend: @sarah)
    
   # @e3 = @mladen.exercises.new(duration_in_min: 70, workout: "wight lifting", workout_date: 8.days.ago)
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
    
  #  expect(page).not_to have_content(@e3.duration_in_min)
  #  expect(page).not_to have_content(@e3.workout)
  #  expect(page).not_to have_content(@e3.workout_date)
    
  end
  
  scenario "shows no exercises if there are none" do
    
    @mladen.exercises.delete_all
    
    visit "/"
    click_link "My Lounge"
    
    expect(page).to have_content("No Workouts yet")
    
  end
  
  scenario "shows user's friends" do
    visit "/"
    click_link "My Lounge"
    
    expect(page).to have_content("My Friends")
    expect(page).to have_link(@sarah.full_name)
    expect(page).to have_link("Unfollow")
  end
  
end