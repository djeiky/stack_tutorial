require_relative 'feature_helper'

feature 'User sign out', %q{
  User can sign out
} do

  given(:user) {create :user}
  scenario 'Authenticated user sign out' do
    sign_in user
    visit root_path
    click_on 'Sign out'


    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non Authenticated user tries sign out' do
    visit root_path

    expect(page).to_not have_content 'Sign out'
  end
end
