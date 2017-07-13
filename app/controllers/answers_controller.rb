class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:new, :create, :destroy]
  before_action :set_answer, only: [:destroy]

  #def new
  #  @answer = @question.answers.build
  #end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = "Your answer successfully created."
      redirect_to question_path(@question)
    else
      flash[:notice] = "Body can't be empty!"
      render 'questions/show'
    end
  end

  def destroy
    if current_user.author_of?(@answer)
      flash[:notice] = "Your answer successfully deleted."
      @answer.destroy
    else

    end
    redirect_to question_path(@question)
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

end
