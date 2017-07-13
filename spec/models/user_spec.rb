require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of :email}
  it {should validate_presence_of :password}

  it {should have_many(:questions).dependent(:destroy)}
  it {should have_many(:answers).dependent(:destroy)}

  describe 'author_of?' do
    let(:user) {create(:user)}
    let(:another_user) {create(:user)}
    let(:question) {create(:question, user: user)}
    let(:another_question) {create(:question, user: another_user)}

    it 'return true if user is the author of the question' do
      expect(user.author_of?(question)).to eq true
    end

    it 'return false if user is not the author of the question' do
      expect(user.author_of?(another_question)).to eq false
    end

    it 'return true if user is the author of the answer' do
    end

    it 'return true if user is not the author of the answer' do
    end

  end
end
