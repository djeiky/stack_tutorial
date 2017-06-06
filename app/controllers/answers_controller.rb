class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    @answer.save
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end

end
