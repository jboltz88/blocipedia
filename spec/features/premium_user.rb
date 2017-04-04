require 'rails_helper'


RSpec.feature "Premium User Uses Site Functions", type: :feature do

  scenario "successfully" do
    # Setup
    # user = User.create(email: 'foo@...')
    user = create(:user, role: 1)
    user2 = create(:user)

    # Exercise
    # log in with existing user
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_text 'Signed in successfully.'

    # create new private Wiki
    first(:link, 'New Wiki').click
    expect(page).to have_text 'New Wiki'
    expect(page).to have_text 'Private'
    fill_in 'Title', with: "Foobar"
    fill_in 'Body', with: "**Bar Bar** ```Foo Bar```"
    page.check('Private Wiki')
    click_button 'Save'
    expect(page).to have_text 'Wiki was successfully saved'
    expect(page).to have_text 'Foobar'
    expect(page).to have_text 'Bar Bar Foo Bar'

    # edit private wiki
    click_link 'Edit Wiki'
    click_link 'Collaborators'
    expect(page).to have_text 'Collaborators for'
    first(:link, 'Add Collaborator').click
    expect(page).to have_text 'Collaborator successfully added'
    first(:link, 'Remove Collaborator').click
    expect(page).to have_text 'Collaborator successfully removed'

    #Assertions
  end
end
