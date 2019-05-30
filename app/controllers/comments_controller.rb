class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership!, only: [:destroy]


  def create
    @new_comment = Comment.new(content: params[:content],
                              trade_id: params[:trade_id],
                              user_id: current_user.id)
    new_comment.save
    redirect_to :back
  end

  def destory
    @comment.destroy
    redirect_to :back
  end

  private
  def check_ownership!
    @comment = Comment.find_by(params[:id])
    redirect_to root_path if @comment.user.id != current_user_id
  end
end
 