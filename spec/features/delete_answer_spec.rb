require_relative 'feature_helper'

feature 'User delete answer', %q{
  In order to delete answer
  I neet to be the author of the answer
} do

  given!(:user) {create(:user)}
  given!(:question) {create(:question, user: user)}
  given!(:answer) {create(:answer, user: user, question: question)}
  given!(:another_question) {create(:question, user: user)}
  given!(:another_answer) {create(:answer, question: another_question, user: create(:user))}
  scenario 'Authenticated user tries to delete own answer' do
    sign_in user
    visit question_path question

    click_on 'Delete answer'

    expect(page).to have_content 'Your answer successfully deleted.'
    expect(page).to_not have_content answer.body
  end
  scenario 'Authenticated user tries to delete own answer' do
    sign_in user
    visit question_path another_question

    expect(page).to_not have_content 'Delete answer'
  end
  scenario 'Authenticated user tries to delete own answer' do
    visit question_path question

    expect(page).to_not have_content 'Delete answer'
  end
end
