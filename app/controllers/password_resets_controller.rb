class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration,
                only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params.require(:password_reset)[:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "flash_password_reset.email_sent"
      redirect_to root_url
    else
      flash.now[:danger] = t "flash_password_reset.email_not_found"
      render :new
    end
  end

  def edit; end

  def update
    if user_params[:password].empty?
      @user.errors.add(:password, "can't be empty")
      render :edit
    elsif @user.update(user_params)
      log_in @user
      flash[:success] = t "flash_password_reset.has_reset"
      redirect_to @user
    else
      flash[:danger] = t "flash_password_reset.update_error"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def load_user
    @user = User.find_by email: params.require(:email)
    return if @user

    flash[:warning] = t "flash_password_reset.not_found"
    redirect_to root_url
  end

  def valid_user
    return if @user.activated? && @user.authenticated?(:reset, params[:id])

    flash[:warning] = t "flash_password_reset.not_valid"
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "flash_password_reset.expired"
    redirect_to new_password_reset_url
  end
end
