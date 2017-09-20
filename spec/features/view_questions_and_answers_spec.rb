require_relative 'feature_helper'

feature "User can view question and it's answers", %q{
  In order to see question with answers
  I want to see question page
} do

  given!(:question) { create :question }
  given!(:answers) { create_list(:answer, 5, question: question) }
  scenario 'User click on question link' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body

    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end
