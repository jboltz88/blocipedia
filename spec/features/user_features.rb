require 'rails_helper'


RSpec.feature "User Creates To Dos", type: :feature do

  scenario "successfully" do
    # Setup
    # user = User.create(email: 'foo@...')
    user = create(:user)

    # Exercise
    # log in with existing user
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_text 'Signed in successfully.'

    # create new Wiki
    first(:link, 'New Wiki').click
    expect(page).to have_text 'New Wiki'
    fill_in 'Title', with: "Foobar"
    fill_in 'Body', with: "**Bar Bar** ```Foo Bar```"
    click_button 'Save'
    expect(page).to have_text 'Wiki was successfully saved'
    expect(page).to have_text 'Foobar'
    expect(page).to have_text 'Bar Bar Foo Bar'

    # view user page
    click_link user.email
    expect(page).to have_text user.name

    # edit user account
    click_link 'Edit profile'
    click_link 'Upgrade to Premium'
    expect(page).to have_text 'Click the button!'

    # return to index
    click_link 'Blocipedia'

    # edit Wiki
    expect(page).to have_text 'Wikis'
    click_link 'Foobar'
    click_link 'Edit Wiki'
    fill_in 'Title', with: "Foo Bar"
    fill_in 'Body', with: "foobarfoobar"
    click_button 'Save'
    expect(page).to have_text "foobarfoobar"
    expect(page).to have_text 'Wiki was successfully updated'

    # sign out
    click_link 'Sign Out'
    expect(page).to have_text 'Signed out successfully'

    # Assertions
  end
end
