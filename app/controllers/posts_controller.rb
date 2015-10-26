class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new params.require(:post).permit(:title, :link)

    if @post.save
      redirect_to posts_path, notice: "Thanks for your post!"
    else
      flash.now[:alert] = @post.errors.full_messages
      render :new
    end
  end
end
