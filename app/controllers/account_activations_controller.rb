class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params.require(:email)
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t "flash_account_activation.activated"
      redirect_to user
    else
      flash[:danger] = t "flash_account_activation.invalid_link"
      redirect_to root_url
    end
  end
end
