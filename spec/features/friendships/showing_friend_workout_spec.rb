require "rails_helper"

RSpec.feature "Showing friend's workouts" do
  
  before do
    @mladen1 = User.create(first_name: "John", last_name: "Doe", email: "john@email.com", password: "password")
    @mladen2 = User.create(first_name: "Bob", last_name: "Doe", email: "bob@email.com", password: "password")
    
    @e1 = @mladen1.exercises.create(duration_in_min: 50, workout: "running", workout_date: Date.today)
    @e2 = @mladen2.exercises.create(duration_in_min: 45, workout: "skiing", workout_date: Date.today)
    
    login_as(@mladen1)
    @following = Friendship.create(user: @mladen1, friend: @mladen2)
    
  end
  
  scenario "show friends workouts for last 7 days" do
    visit "/"
    click_link "My Lounge"
    click_link @mladen2.full_name
    
    expect(page).to have_content("#{@mladen2.full_name}'s Exercises")
    expect(page).to have_content(@e2.workout)
    expect(page).to have_css("div#chart")
    
  end
  
end