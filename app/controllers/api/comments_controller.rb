class Api::CommentsController < Api::ApplicationController
  def index
    post = Post.find(params[:post_id])
    comments = post.comments
    render json: comments
  end

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.build(comment_params)
    comment.user = current_user

    if comment.save
      render json: comment, status: :created
    else
      render json: { error: 'Comment could not be created.' }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
