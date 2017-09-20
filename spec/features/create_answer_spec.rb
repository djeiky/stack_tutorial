require_relative 'feature_helper'

feature 'User answer the question', %q{
  In order to answer question
  I need to fill the form
} do

  given(:user) { create(:user) }
  given(:question) {create(:question, user: user)}

  scenario 'Authenticated user create answer', js: true do
    sign_in user

    visit question_path(question)

    fill_in 'Body', with: "comment"
    click_on 'Create answer'

    within ".answers" do
      expect(page).to have_content "comment"
    end
  end

  scenario 'Authenticated user tries to answer the question with blank answer', js: true do
    sign_in user
    visit question_path question

    click_on 'Create answer'

    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Non-Registered user tries to create answer' do
    visit question_path question

    click_on 'Create answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
