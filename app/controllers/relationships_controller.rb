class RelationshipsController < ApplicationController
  before_action :user_signed_in?

  def create
    @user = User.find_by id: params[:followed_id]

    if @user
      current_user.follow @user
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      render file: "public/404.html", layout: false
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed

    if @user
      current_user.unfollow @user
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      render file: "public/404.html", layout: false
    end
  end
end
