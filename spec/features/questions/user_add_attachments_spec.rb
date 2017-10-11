require_relative '../feature_helper'

feature 'User add attachments', %q{
  In order to attach file to the question
  User has oppotunity to add file
} do

  given(:user) {create(:user)}
  given(:question) {create(:question, user: user)}

  background do
    sign_in user
  end

  scenario "User adds attachment while creating question", js: true do
    visit new_question_path
    fill_in "Title", with: "NewTitle"
    fill_in "Body", with: "NewBody"
    attach_file "File", "#{Rails.root}/spec/rails_helper.rb"
    
    click_on "Save"

    expect(page).to have_link "rails_helper", href: "/uploads/attachment/file/1/rails_helper.rb"

  end

  scenario "User can attach file while editing question", js: true do
    visit edit_question_path(question)
    attach_file "File", "#{Rails.root}/spec/rails_helper.rb"
   
    click_on 'Add file'
    expect(page).to have_content("File", count: 2)
    all('input[type="file"]').last.set("#{Rails.root}/spec/spec_helper.rb")
    
    click_on "Save"
    expect(page).to have_link "rails_helper.rb", href: "/uploads/attachment/file/1/rails_helper.rb"
    expect(page).to have_link "spec_helper.rb", href: "/uploads/attachment/file/2/spec_helper.rb"

    
  end

end
