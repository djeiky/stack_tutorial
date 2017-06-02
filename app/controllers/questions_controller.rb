class QuestionsController < ApplicationController

  before_filter :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(questions_params)
    if @question.save
      redirect_to questions_path
    else
      render :new
    end
  end

  def show
    @answer = @question.answers.build
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :body)
  end


end
