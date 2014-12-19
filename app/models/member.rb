class Member < ActiveRecord::Base
  validates :email, uniqueness: true
  has_many :guesses

  def add_answer?
    return is_admin? && !answer_exists?
  end

  def answer_exists?
    Answer.where(created_at: Date.today..Date.tomorrow).count > 0
  end

  def is_admin?
    return role == 1
  end

  def can_answer?
    return role == 2 && !answered? && answer_exists?
  end

  def answered?
    return guesses.where(created_at: Date.today..Date.tomorrow).count > 0
  end

  def yesterday_answer
    a = Answer.where(created_at: Date.yesterday..Date.today)
    if a.count > 0
      return a.first.word
    end
    "There was no word yesterday."
  end

  def yesterday_guess
    g = guesses.where(created_at: Date.yesterday..Date.today)
    if g.count > 0
      return g.first.word
    end
    "You gave no guess yesterday."
  end
end
