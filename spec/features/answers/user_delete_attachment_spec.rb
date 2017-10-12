require_relative '../feature_helper'

feature 'User delete attachments to answer', %q{
  In order to delete file
  User has oppotunity to delete file
} do
  
  given(:user) {create(:user)}
  given!(:question) {create(:question, user: user)}
  given!(:answer) {create(:answer, question: question, user: user)}
  given!(:attachment) {create(:attachment, attachable: answer)}
  
  scenario "User deletes attachment from his own answer", js: true do
    sign_in user

    visit question_path(question)
    within ".answers" do
      click_on "Edit"
      find(".nested-fields.delete_attachments_#{attachment.id}>a").click
      click_on "Save"
    end
    
    expect(page).to_not have_link "rails_helper", href: "/uploads/attachment/file/1/rails_helper.rb"
  end
end

