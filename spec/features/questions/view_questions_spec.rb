require_relative '../feature_helper'

feature 'Any user view list of questions', %q{
  In order to find question
  I want to see list of questions
} do
  given!(:questions) { create_list( :question, 5 ) }

  scenario 'User can see list of questions' do
    visit questions_path

    questions.each do |q|
      expect(page).to have_content q.title
    end
  end
end
