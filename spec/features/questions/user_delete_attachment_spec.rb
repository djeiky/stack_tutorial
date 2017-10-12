require_relative '../feature_helper'

feature 'User delete attachments', %q{
  In order to delete file of the question
  User has oppotunity to delete file
} do

  given(:user) {create(:user)}
  given(:question) {create(:question, user: user)}
  given!(:attachment) {create(:attachment, attachable: question)}
  background do
    sign_in user
  end

  scenario "User deletes attachment of the question", js: true do
    visit edit_question_path(question)
    click_on "delete file" 
    click_on "Save"

    expect(page).to_not have_link "rails_helper", href: "/uploads/attachment/file/1/rails_helper.rb"

  end
end
