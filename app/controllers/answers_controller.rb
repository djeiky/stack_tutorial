class AnswersController < ApplicationController


  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to question_path(@answer.question_id)
    else
      redirect_to question_path(@answer.question_id)
    end

  end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end

end
