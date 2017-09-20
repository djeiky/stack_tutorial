require_relative 'feature_helper'

feature 'User sign in', %q{
  In order to ask questions and give answers
  user should sign_in
} do

  given(:user) {create :user}

  scenario 'Authenticated user attemps to sign in' do
    sign_in user

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-Registered user attemps to sign_in' do
    visit new_user_session_path
    fill_in 'Email', with: 'incorrect@mail.com'
    fill_in 'Password', with: 'incorrect_password'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end
end
