require_relative '../feature_helper'

feature "Users can edit answers", %q{
  In order to edit answer
  Users have the oppotunity edit answers
} do

  given!(:user) { create(:user) }
  given!(:question) {create(:question, user: user)}
  given(:answer) {create(:answer, question: question, user: user)}
  given!(:another_user) {create(:user)}
  given(:another_answer) {create(:answer, question: question, user: another_user)}

  scenario "Unauthenticated user can't edit answers", js: true do
    visit question_path(question)

    expect(page).to_not have_link "Edit"
  end

  scenario "Authot of the answer can edit answer", js: true do
    answer
    sign_in user
    visit question_path(question)

    within ".answers" do
      click_on "Edit"
      fill_in "Body", with: "answer has been edeted"
      click_on "Save"

      expect(page).to_not have_content answer.body
      expect(page).to have_content "answer has been edeted"
      expect(page).to_not have_selector "textarea"
    end
  end

  scenario "Authenticated user can't edit answer of other user", js: true do
    another_answer
    sign_in user
    visit question_path(question)

    expect(page).to_not have_selector ".edit-answer-link[data-answer-id=\"#{another_answer.id}\"]"

  end
end
