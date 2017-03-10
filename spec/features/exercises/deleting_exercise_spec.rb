require "rails_helper"

RSpec.feature "Delete exercise" do
  
  before do
    @mladen = User.create!(first_name: "Mladen", last_name: "Marjanovic", email: "mladen@email.com", password: "password")
    login_as(@mladen)
    
    @e1 = @mladen.exercises.new(duration_in_min: 50, workout: "running", workout_date: Date.today)
  end
  
  scenario do
    
    visit "/"
    click_link "My Lounge"
    
    path = "/users/#{@mladen.id}/exercises/#{@e1.id}"
    link = "//a[contains(@href,\'#{path}\') and .//text()='Destroy']"
    
    find(:xpath, link).click
    
    expect(page).to have_content("Exercise has been deleted")
    
  end
  
end