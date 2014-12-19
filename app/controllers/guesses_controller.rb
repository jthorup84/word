class GuessesController < ApplicationController
  def create
    correct = guess_params[:word] == Answer.last.word
    member = Member.find session[:user_id]
    if !member.answered?
      member.score += 1 unless !correct
      member.save
      member.guesses.create(word: guess_params[:word], correct: correct)
    end
    redirect_to member_path(Member.find session[:user_id])
  end


  private

  def guess_params
    params.require(:new_guess).permit(:word)
  end
end
