require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'show array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assings question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before {get :new}

    it 'assigns @question to a new Question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before {get :edit, params: {id: question}}

    it 'assigns @question to requested question' do
      expect(assigns(:question)).to eq question
    end

    it 'remder edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do

    context 'valid attributes' do
      it 'saves question to database' do
        expect{post :create, params: {question: attributes_for(:question)}}.to change(Question, :count).by(1)
      end

      it 'redirect to show view' do
        post :create, params: {question: attributes_for(:question)}
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'invalid attributes' do
      it 'not save the question' do
        expect{post :create, params: {question: attributes_for(:invalid_question)}}.to_not change(Question, :count)
      end

      it 'render new view' do
        post :create, params: {question: attributes_for(:invalid_question)}
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      it 'assigns @question to requested question' do
        patch :update, params: {id: question, question: attributes_for(:question)}
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        patch :update, params: {id: question, question: {title: "NewTitle", body: "NewBody"}}
        question.reload
        expect(question.title).to eq "NewTitle"
        expect(question.body).to eq "NewBody"

      end

      it 'redirects to updated question' do
         patch :update, params: {id: question, question: {title: "NewTitle", body: "NewBody"}}
         expect(response). to redirect_to question

      end
    end

    context 'invalid attributes' do
      before { patch :update, params: {id: question, question: {title: nil, body: "body"}} }

      it 'not save updated question' do
        question.reload
        expect(question.title).to eq "MyString"
        expect(question.body).to eq "MyText"
      end

      it 'render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before {question}

    it 'deletes question' do
      expect{ delete :destroy, params:{id: question} }.to change(Question, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, params: { id: question  }
      expect(response).to redirect_to questions_path
    end
  end
end
