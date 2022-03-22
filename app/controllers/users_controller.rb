class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy following
                                          followers)
  before_action :load_user, only: %i(show edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy User.all, items: Settings.const.pagy_items
  end

  def show
    if @user
      @pagy, @microposts = pagy @user.microposts,
                                items: Settings.const.pagy_items
    end
    flash[:warning] = t "flash_user.not_found"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "flash_user.check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t "flash_user.updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "flash_user.deleted"
    else
      flash[:danger] = t "flash_user.error"
    end
    redirect_to users_url
  end

  def following
    @title = t "follow_title.following"
    @user = User.find_by id: params.require(:id)
    @pagy, @users = pagy @user.following, items: Settings.const.pagy_items
    render :show_follow
  end

  def followers
    @title = t "follow_title.followers"
    @user = User.find_by id: params.require(:id)
    @pagy, @users = pagy @user.followers, items: Settings.const.pagy_items
    render :show_follow
  end

  private

  def load_user
    @user = User.find_by id: params.require(:id)
    return if @user

    flash[:warning] = t "flash_user.not_found"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def correct_user
    return if current_user? @user

    flash[:warning] = t "flash_user.not_user"
    redirect_to root_url
  end

  def admin_user
    return if current_user.admin?

    flash[:warning] = t "flash_user.not_admin"
    redirect_to root_url
  end
end
