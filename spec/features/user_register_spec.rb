require 'rails_helper'

feature 'Register user', %q{
  User can register
  in order to able to ask questions and give answers
} do

  scenario 'Non Registered user can register' do
    visit new_user_registration_path
    fill_in 'Email', with: 'new_user@test.ru'
    fill_in 'Password', with: '123456789'
    fill_in 'Password confirmation', with: '123456789'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end

  let(:user) {create :user}
  scenario 'Authenticated user can not register' do
    sign_in user
    visit new_user_registration_path

    expect(page).to have_content 'You are already signed in.'
  end
end
