class PostsController < ApplicationController
  before_action :load_post, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.search_post(params[:search]).post_order.page(params[:page]).
      per Settings.post.post_number
    @hot_user = User.hot_user
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build post_params

    if @post.save
      flash[:success] = t ".created_post"
      redirect_to @post
    else
      flash.now[:error] = t ".create_fail"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update post_params
      flash[:success] = t ".update_post"
      redirect_to post_path @post
    else
      flash.now[:error] = t ".update_fail"
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t ".destroy_post"
      redirect_to user_path current_user
    else
      flash.now[:error] = t ".destroy_fail"
      redirect_to @post
    end
  end

  private

  def post_params
    params.require(:post).permit :title, :content, :user_id
  end

  def load_post
    @post = Post.find_by id: params[:id]

    check_url @post
  end
end
