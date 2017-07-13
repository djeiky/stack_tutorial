require 'rails_helper'

feature 'Create questions', %q{
  In order to get answers
  as authenticated user
  I want to be able to ask questions
} do

  given(:user) {create :user}

  scenario 'Authenticated user creates a question' do
    sign_in user
    visit root_path
    click_on "Ask question"

    fill_in "Title", with: "NewTitle"
    fill_in "Body", with: "NewBody"
    click_on "Create"

    expect(page).to have_content 'Your question successfully created.'
    expect(page).to have_content 'NewTitle'
    expect(page).to have_content 'NewBody'
  end

  scenario 'Non-Authenticated user tries to create a question' do
    visit root_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end
