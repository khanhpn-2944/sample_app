class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: session_params[:email].downcase
    if user&.authenticate session_params[:password]
      log_in user
      session_params[:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash[:danger] = t "flash_session.create_fail"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit :email, :password, :remember_me
  end
end
