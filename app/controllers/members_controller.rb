class MembersController < ApplicationController

  before_action :authorize, except: [:login, :logout, :new, :create]

  def login
    if (@member = Member.find_by_email login_params[:email])
      if @member.password == Digest::SHA2.hexdigest(@member.salt + login_params[:password])
        session[:user_id] = @member.id
        redirect_to member_path(@member)
      else
        redirect_to  '/welcome/index'
      end
    else
      redirect_to  '/welcome/index'
    end
  end

  def logout
    reset_session
  end

  def index
    @member = Member.find session[:user_id]
    @members = Member.order(score: :desc)
  end

  def new

  end

  def show
    @member = Member.find(params[:id])
    @answer = "Has not been created yet!"
    @hint = "Has not been created yet!"
    if @member.answer_exists?
      @answer = Answer.where(created_at: Date.today..Date.tomorrow).first.word
      @hint = "Starts with the letter '" + @answer[0].to_s + "' and contains " + @answer.length.to_s + " letters."
    end
    if session[:user_id].to_s != params[:id].to_s && @currentMember.role != 1
      redirect_to members_path
    end
  end

  def create
    @member = Member.create(email: member_params[:email], first_name:  member_params[:first_name], last_name:  member_params[:last_name], role: 2, score: 0)
    if @member.valid?
      @member.update_attribute(:salt,  SecureRandom.base64(8))
      @member.update_attribute(:password, Digest::SHA2.hexdigest(@member.salt + member_params[:password]))
    end
    redirect_to welcome_index_path
  end

  private
  def member_params
    params.require(:member).permit(:email, :password, :first_name, :last_name)
  end

  def login_params
    params.require(:member).permit(:email, :password)
  end


  def authorize
    if !session[:user_id]
      redirect_to '/welcome/index'
    end
    @currentMember = Member.find(session[:user_id])
  end
end
