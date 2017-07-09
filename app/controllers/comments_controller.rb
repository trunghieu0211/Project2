class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @post.comments.create comment_params
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html {redirect_to @post}
        format.js
      else
        format.html {render :new}
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comment.update comment_params
        format.html {redirect_to @post}
        format.js
      else
        format.html {render :edit}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.html {redirect_to @post}
        format.js
      else
        format.html {redirect_to @post}
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def find_post
    @post = Post.find_by post_id: params[:post_id]

    check_url @post
  end

  def find_comment
    @comment = @post.comments.find_by id: params[:id]

    check_url @comment
  end
end
