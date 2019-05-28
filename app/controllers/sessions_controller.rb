class SessionsController < ApplicationController

  def index
    render 'homepage'
  end

  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    @login_failed = false
    if @user && @user.authenticate(params[:password])
      log_in @user
      redirect_to :root
    else
      @login_failed = true
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to :root
  end
end
