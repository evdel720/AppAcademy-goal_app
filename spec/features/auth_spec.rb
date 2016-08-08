require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before :each do
    visit '/users/new'
  end

  scenario "has a new user page" do
    expect(page).to have_content('Sign Up')
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      visit '/users/new'
      fill_in 'Username', with: 'Something'
      fill_in 'Password', with: 'Password'
      click_on 'Sign Up!'
      expect(page).to have_content('Something')
    end

    scenario "shows errors on failed validations" do
      visit '/users/new'
      fill_in 'Username', with: 'Something'
      fill_in 'Password', with: '111'
      click_on 'Sign Up!'
      expect(page).to have_content('Password is too short')
    end

  end

end

feature "logging in" do
  let(:user) { FactoryGirl.create(:user) }
  before :each do
    visit '/session/new'
  end

  scenario "shows username on the homepage after login" do
    fill_in 'Username', with: user.username
    fill_in 'Password', with: '123456'
    click_on 'Sign In!'
    expect(page).to have_content(user.username)
  end

  scenario "shows errors on failed validations" do
    fill_in 'Username', with: user.username
    fill_in 'Password', with: '1256'
    click_on 'Sign In!'
    expect(page).to have_content('Invalid')
  end

end

feature "logging out" do
  let(:user) { FactoryGirl.create(:user) }
  before :each do
    visit '/session/new'
    fill_in 'Username', with: user.username
    fill_in 'Password', with: '123456'
    click_on 'Sign In!'
    save_and_open_page
    click_on 'Sign Out'
  end

  scenario "begins with a logged out state" do
    expect(page).to have_button('Sign In')
  end

  scenario "doesn't show username on the homepage after logout" do
    expect(page).not_to have_content(user.username)
  end

end
