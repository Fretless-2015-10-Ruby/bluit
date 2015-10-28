class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.includes(:category)
      .includes(:user)
      .includes(comment_threads: [:user])
      .paginate(page: params[:page])
  end

  def show
    if user_signed_in?
      @comment = Comment.build_from(@post, current_user.id, "")
    end
  end

  def new
    @post = Post.new
  end

  def edit
    if @post.user != current_user
      redirect_to posts_path, alert: "You are not allowed to edit that post."
    end
  end

  def create
    @post = Post.new post_params
    @post.user_id = current_user.id

    if @post.save
      redirect_to posts_path, notice: "Thanks for your post!"
    else
      flash.now[:alert] = @post.errors.full_messages
      render :new
    end
  end

  def update
    if @post.user == current_user
      if @post.update post_params
        redirect_to posts_path, notice: "Your changes have been saved."
      else
        flash.now[:alert] = @post.errors.full_messages
        render :edit
      end
    else
      redirect_to posts_path, alert: "You are not allowed to edit that post."
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: "Your post has been removed."
    else
      redirect_to posts_path, alert: "We were unable to remove that post."
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :link, :category_id)
  end
end
