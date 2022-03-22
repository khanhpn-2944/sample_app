class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params.require(:followed_id)
    current_user.follow @user
    flash[:success] = t "flash_relationships.follow_success"
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find_by(id: params.require(:id)).followed
    current_user.unfollow @user
    flash[:success] = t "flash_relationships.unfollow_success"
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end
end
