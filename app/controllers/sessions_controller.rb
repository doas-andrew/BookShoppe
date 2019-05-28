class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    @login_failed = false
    if @user && @user.authenticate(params[:password])
      session[:current_user_id] = @user.id
      log_in(@user)
      redirect_to :root
    else
      @login_failed = true
      render 'new'
    end
  end
  
  def destroy
    session[:current_user_id] = nil
    log_out
    redirect_to :root
  end
end
