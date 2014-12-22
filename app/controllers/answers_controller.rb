class AnswersController < ApplicationController
  def index

  end

  def create
    Answer.create(word: answer_params[:word])
    Member.find_each do |member|
      WordMailer.new_word_email(member).deliver
    end
    redirect_to member_path(Member.find session[:user_id])
  end


  private

  def answer_params
    params.require(:new_answer).permit(:word)
  end
end
