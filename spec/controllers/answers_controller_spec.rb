require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do

  let(:answer) {create :answer}
  let(:question) { create :question }

  describe 'GET #new' do
    before { get :new, params: {question_id: question}}

    it 'assigns @answer to a new Answer, that has Question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'valid answer' do
      it 'save answer to database' do
        expect{post :create, params: {question_id: question, answer: attributes_for(:answer)}}.to change(question.answers, :count).by(1)
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

      it 'render new view' do
        post :create, params: {question_id: question, answer: attributes_for(:invalid_answer)}
        expect(response).to render_template :new
      end
    end
  end
end

