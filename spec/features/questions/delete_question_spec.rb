require_relative '../feature_helper'

feature 'User delete question', %q{
  In order to delete question
  I need to be an author of the question
} do

  given(:user) {create(:user)}
  given(:question) {create(:question, user: user)}
  given(:another_user) {create(:user)}
  given(:another_user_question) {create(:question, user: another_user)}
  scenario 'Authenticated user tries to delete own question' do
    sign_in user
    visit question_path( question)

    click_on 'Delete question'

    expect(page).to have_content 'Your question seccessfully deleted.'
    expect(page).to_not have_content question.title
    expect(current_path).to eq questions_path
  end

  scenario "Authenticated user tries to delete someone else author's question" do
    sign_in user
    visit question_path(another_user_question)

    expect(page).to_not have_content 'Delete question'
  end

  scenario "Non-registered user tries to delete question" do
    visit question_path question

    expect(page).to_not have_content 'Delete question'
  end
end
