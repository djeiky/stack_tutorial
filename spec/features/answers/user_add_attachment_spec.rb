require_relative '../feature_helper'

feature 'User add attachments to answer', %q{
  In order to attach file to the answer
  User has oppotunity to add file
} do
  
  given(:user) {create(:user)}
  given!(:question) {create(:question)}

  
  describe "User create answer" do
    background do
      sign_in user
    end


    scenario "with attachment", js: true do
      visit question_path(question)
      fill_in "new_answer_body", with: "Comment"
      attach_file "File", "#{Rails.root}/spec/rails_helper.rb"
      click_on "Create answer"
      
      within(".answers") do
        expect(page).to have_content "Comment"
        expect(page).to have_link "rails_helper.rb", href: "/uploads/attachment/file/1/rails_helper.rb"
      end

    end

    scenario "with several attachments", js: true do

    end
  end

  scenario "User deletes attachment from his own answer", js: true do

  end

  scenario "User can't delete another user attachment", js: true do

  end

end

