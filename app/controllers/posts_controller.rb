class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:id])
    @user = User.find(params[:id])
  end

  def show
    @post = Post.find(params[:post_id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.likes_counter = 0
    @post.comment_counter = 0

    if @post.save
      redirect_to users_path
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
