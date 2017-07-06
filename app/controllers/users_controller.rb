class UsersController < ApplicationController

  def index
    @users = User.user_order.page(params[:page]).per Settings.user.user_number
  end

  def show
    @user = User.find_by id: params[:id]

    if @user
      @posts = @user.posts.post_order.page(params[:page]).per Settings.post.post_number
    else
      render file: "public/404.html", layout: false
    end
  end
end
