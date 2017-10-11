require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :title }
  it {should validate_presence_of :body }
  it {should have_many(:answers).dependent(:destroy) }
  it {should belong_to(:user)}
  it {should have_many(:attachments).dependent(:destroy)}

  it {should accept_nested_attributes_for :attachments}

  let(:user) {create(:user) }
  let(:question) {create(:question, user: user)}
  let!(:answers) {create_list(:answer, 3, question: question, user: user)}

  it "Shoule have best answer first" do
    question.answers.second.set_best
    question.reload

    expect(question.answers.first.best).to be true

  end
end
