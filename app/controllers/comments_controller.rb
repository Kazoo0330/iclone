class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to post_path(@post), notice: 'unable to post.' }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit %i[post_id content]
  end
end
