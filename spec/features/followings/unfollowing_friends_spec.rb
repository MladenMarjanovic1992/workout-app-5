require "rails_helper"

RSpec.feature "Unfollowing Friends" do
  before do
    @john = User.create(first_name: "John",
                        last_name: "Doe",
                        email: "john@example.com",
                        password: "password")

    @peter = User.create(first_name: "Peter",
                        last_name: "Corn",
                        email: "peter@example.com",
                        password: "password")
    login_as(@john)
    
    @following = Friendship.create(user: @john, friend: @peter)
  end

  scenario "if signed in" do
    visit "/"

    click_link "My Lounge"

    link = "a[href='/friendships/#{@following.id}'][data-method='delete']"
    find(link).click

    expect(page).to have_content(@peter.full_name + " unfollowed")
  end
end