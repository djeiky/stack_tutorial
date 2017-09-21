class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:new, :create, :destroy, :update]
  before_action :set_answer, only: [:destroy, :update]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    render "error" unless @answer.save

  end

  def update
    if current_user.author_of?(@answer)
      render "error" unless @answer.update(answer_params)
    else
      flash[:notice] = "You are not auther of the answer"
    end
  end

  def destroy
    if current_user.author_of?(@answer)
      flash[:notice] = "Your answer successfully deleted."
      @answer.destroy
    else
      flash[:notice] = "You are not author of the answer"
    end
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
