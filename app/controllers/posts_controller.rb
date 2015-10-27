class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new post_params

    if @post.save
      redirect_to posts_path, notice: "Thanks for your post!"
    else
      flash.now[:alert] = @post.errors.full_messages
      render :new
    end
  end

  def update
    if @post.update post_params
      redirect_to posts_path, notice: "Your changes have been saved."
    else
      flash.now[:alert] = @post.errors.full_messages
      render :edit
    end
  end

  private

  def find_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :link)
  end
end
