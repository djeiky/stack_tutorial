require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  sign_in_user
  let!(:question) { create(:question, user: @user) }
  let!(:answer) {create( :answer, question: question)}

  describe 'POST #create' do
    context 'valid answer' do
      it 'save answer to database' do
        expect{post :create, params: { question_id: question, answer: attributes_for(:answer)}}.to change(question.answers, :count).by(1)
      end

      it 'assings answer to current user' do
        post :create, params: { question_id: question, answer: attributes_for(:answer)}
        expect(assigns(:answer).user).to eq @user
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

  describe 'DELETE #destroy' do
    sign_in_user
    it "user tries to delete own answer" do
      answer = create(:answer, question: question, user: @user)

      expect{delete :destroy, params:{ question_id: question, id: answer}}.to change(Answer, :count).by(-1)

    end

    it "user can't delete someone else question" do
      another_answer = create(:answer, question: question, user: create(:user))
      expect{delete :destroy, params: {question_id: question, id: another_answer}}.to_not change(Answer, :count)
    end

    it "redirects to question show page" do
      delete :destroy, params: {question_id: question, id: answer}
      expect(response).to redirect_to question_path(question)
    end
  end
end

