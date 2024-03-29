class Public::PostsController < ApplicationController
  before_action :authenticate_any!

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
     redirect_to post_path(current_end_user.display_name, @post.id)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.end_user != current_end_user
      redirect_to post_path(@post.end_user.display_name, @post.id)
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(current_end_user.display_name, @post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:body, :image)
  end

end
