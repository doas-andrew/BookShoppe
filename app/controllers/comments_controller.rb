class CommentsController < ApplicationController

  def create
    Comment.create(comment_params) if params[:comment][:content]
    redirect_to trade_path(params[:comment][:trade_id])
  end

  # currently unused
  def destroy
  	@comment = Comment.find(params[:id])
  	path = trade_path(@comment.trade)
  	@comment.destroy
  	redirect_to path
  end

  private
  def comment_params
    params.require(:comment).permit(:trade_id, :user_id, :content)
  end
end
