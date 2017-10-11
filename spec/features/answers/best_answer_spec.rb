require_relative '../feature_helper'

feature 'choose best answer', %q{
  In order to choose best answer
  As author of the question
  I want to be able choose an answer
} do

  describe "Author's question" do
    given(:user) { create(:user) }
    given(:question) {create(:question, user: user)}
    given(:answers) {create_list(:answer, 3 , question: question)}
    given(:another_user) {create(:user)}
    given(:another_question) {create(:question, user: another_user)}
    given(:another_answers) {create_list(:answer, 3, question: another_question)}

    scenario "Author tries to choose best answer", js: true do
      sign_in user
      answers
      visit question_path(question)

      click_on "best", match: :first

      expect(page).to have_css ".best-answer"
    end

    scenario "User tries to choose best answer for another user question" do
      sign_in user
      visit question_path(another_question)

      expect(page).to_not have_link "best"
    end

  end

end

