class WelcomeController < ApplicationController
  def index
  end

  def logout
    reset_session
    redirect_to welcome_index_path
  end
end
