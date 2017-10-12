require 'rails_helper'

RSpec.describe Answer, type: :model do
  it {should validate_presence_of :body }

  it {should have_many(:attachments).dependent(:destroy)}
  it {should accept_nested_attributes_for(:attachments) }

  it {should belong_to :question }
  it {should belong_to :user}

  let(:user) {create(:user)}
  let(:question) {create(:question)}
  let!(:answers) {create_list(:answer, 3, question: question, user: user)}
  
  it "should set first answer to best" do
    question.answers.first.set_best
    expect(question.answers.first.best).to be true
  end

  it "should set second ansewr to best and first answer to false" do
    first_answer = question.answers.first
    second_answer = question.answers.second
    second_answer.set_best
    question.reload
    expect(second_answer.best).to be true
    expect(first_answer.best).to be false
  end
end
