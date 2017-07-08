class UsersController < ApplicationController

  def index
    @users = User.user_order.page(params[:page]).per Settings.user.user_number
  end

  def show
    @user = User.find_by id: params[:id]

    if @user
      @posts = @user.posts.post_order.page(params[:page]).per Settings.post.post_number
      @users_following = @user.following.page(params[:page]).per Settings.user.user_number
      @users_follow = @user.followers.page(params[:page]).per Settings.user.user_number
    else
      render file: "public/404.html", layout: false
    end
  end

  def following
    @title = t ".following"
    @user  = User.find_by id: params[:id]

    if @user
      @users =  @user.following.page(params[:page]).per Settings.user.user_number
      @posts = Post.of_followed_users(@user.following).post_order.page(params[:page]).per Settings.post.post_number
      render "show_post_follow"
    else
      render file: "public/404.html", layout: false
    end
  end
end
