class SessionsController < ApplicationController
  before_action :load_user, only: :create

  def new; end

  def create
    return check_activated if @user.authenticate session_params[:password]

    flash[:danger] = t "flash_session.create_fail"
    render :new
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def load_user
    @user = User.find_by email: session_params[:email].downcase
    return if @user

    flash[:warning] = t "flash_session.not_found"
    redirect_to login_url
  end

  def session_params
    params.require(:session).permit :email, :password, :remember_me
  end

  def check_activated
    if @user.activated?
      log_in @user
      session_params[:remember_me] == "1" ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      flash[:warning] = t "flash_session.not_activated"
      redirect_to root_url
    end
  end
end
