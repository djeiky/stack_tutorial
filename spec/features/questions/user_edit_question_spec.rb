require_relative '../feature_helper'

feature "Users can edit questions", %q{
  In order to edit answer
  Users have the oppotunity edit answers
} do

  given!(:user) { create(:user) }
  given(:question) {create(:question, user: user)}
  given!(:another_user) {create(:user)}
  given(:another_question) {create(:question, user: another_user)}

  scenario "Unauthenticated user can't edit questions" do
    question
    visit questions_path

    expect(page).to_not have_link "Edit"
  end

  scenario "Authot of the question can edit answer", js: true do
    question
    sign_in user
    visit questions_path

    click_on "Edit"
    fill_in "Title", with: "edited title"
    fill_in "Body", with: "edited body"
    click_on "Save"

    expect(page).to_not have_content question.title
    expect(page).to have_content "edited title"
    expect(page).to_not have_selector('question[body]')

  end

  scenario "Authenticated user can't edit answer of other user" do
    another_question
    sign_in user
    visit edit_question_path(another_question)

    expect(current_path).to eq questions_path

  end
end
