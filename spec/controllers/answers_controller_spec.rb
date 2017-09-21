require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  sign_in_user
  let!(:question) { create(:question, user: @user) }
  let!(:answer) {create( :answer, question: question, user: @user)}

  describe 'POST #create' do
    context 'valid answer' do
      it 'save answer to database' do
        expect{post :create, params: { question_id: question, answer: attributes_for(:answer)}, format: :js}.to change(question.answers, :count).by(1)
      end

      it 'assings answer to current user' do
        post :create, params: { question_id: question, answer: attributes_for(:answer)}, format: :js
        expect(assigns(:answer).user).to eq @user
      end

      it 'render create answer template' do
        post :create, params: {question_id: question, answer: attributes_for(:answer)}, format: :js
        expect(response).to render_template :create
      end


    end

    context 'invalid answer' do
      it 'not save to database' do
        expect{post :create, params: {question_id: question, answer: attributes_for(:invalid_answer)}, format: :js}.to_not change(Answer, :count)
      end

      it 'render question show vie' do
        post :create, params: {question_id: question, answer: attributes_for(:invalid_answer)}, format: :js
        expect(response).to render_template 'error'
      end
    end
  end

  describe 'PATCH #update' do

    it 'assigns @answer to requested answer' do
      patch :update, params: {id: answer, question_id: question, answer: attributes_for(:answer)}, format: :js
      expect(assigns(:answer)).to eq answer
    end

    it 'changes answer attributes' do
      patch :update, params: {id: answer, question_id: question, answer: {body: "NewBody"}}, format: :js
      answer.reload
      expect(answer.body).to eq "NewBody"

    end

    it 'render template update' do
      patch :update, params: {id: answer, question_id: question, answer: {body: "NewBody"}}, format: :js
      expect(response).to render_template :update
    end

    it 'render error template if errors exists' do
      patch :update, params: {id: answer, question_id: question, answer: {body: ""}}, format: :js
      expect(response).to render_template :error
    end

    let!(:another_user) {create(:user)}
    let(:another_answer) {create(:answer, question: question, user: another_user)}
    it 'not change answer if user not author' do
       patch :update, params: {id: another_answer, question_id: question, answer: {body: "NewBody"}}, format: :js
       another_answer.reload
       expect(another_answer.body).to eq "Answer body"

    end

  end

  describe 'DELETE #destroy' do
    sign_in_user
    it "user tries to delete own answer" do
      answer = create(:answer, question: question, user: @user)

      expect{delete :destroy, params:{ question_id: question, id: answer}, format: :js}.to change(Answer, :count).by(-1)

    end

    it "user can't delete someone else question" do
      another_answer = create(:answer, question: question, user: create(:user))
      expect{delete :destroy, params: {question_id: question, id: another_answer}, format: :js}.to_not change(Answer, :count)
    end

    it "render destroy template" do
      delete :destroy, params: {question_id: question, id: answer}, format: :js
      expect(response).to render_template :destroy
    end
  end
end

