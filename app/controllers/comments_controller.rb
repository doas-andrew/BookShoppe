class CommentsController < ApplicationController

  def create
    byebug
    Comment.create(comment_params) if !params[:comment][:content].empty?
    redirect_to trade_path(params[:comment][:trade_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:trade_id, :user_id, :content)
  end
end
 