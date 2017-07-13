require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  sign_in_user
  let!(:question) { create(:question, user: @user) }
  let!(:answer) {create( :answer, user: @user, question: question)}

  describe 'POST #create' do
    context 'valid answer' do
      it 'save answer to database' do
        expect{post :create, params: {user: @user, question_id: question, answer: attributes_for(:answer)}}.to change(question.answers, :count).by(1)
      end

      it 'redirect to question show view' do
        post :create, params: {question_id: question, answer: attributes_for(:answer)}
        expect(response).to redirect_to question_path(question)
      end


    end

    context 'invalid answer' do
      it 'not save to database' do
        expect{post :create, params: {question_id: question, answer: attributes_for(:invalid_answer)}}.to_not change(Answer, :count)
      end

      it 'render question show vie' do
        post :create, params: {question_id: question, answer: attributes_for(:invalid_answer)}
        expect(response).to render_template 'questions/show'
      end
    end
  end
end

