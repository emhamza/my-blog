class CommentsController < ApplicationController
  def new
    @commnet = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:post_id]

    if @comment.save
      redirect_to users_path
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:comment_del])

    @comment.destroy

    respond_to do |format|
      format.html do
        redirect_to "/users/#{params[:user_id]}/posts/#{params[:id]}", notice: 'Your comment is deleted!'
      end
      format.json { head :no_content }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
