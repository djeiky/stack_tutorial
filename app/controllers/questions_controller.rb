class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(questions_params)
    if @question.save
      flash[:notice] = 'Your question successfully created.'
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def show
    @answer = Answer.new#@question.answers.build
  end

  def edit
  end

  def update
    if @question.update(questions_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      flash[:notice] = "Your question seccessfully deleted."
    else
    end
    redirect_to questions_path
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :body)
  end
end
