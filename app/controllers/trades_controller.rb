class TradesController < ApplicationController

	before_action :set_trade, only: [:show, :destroy]

	def show
		if @trade.sender.id == session[:current_user_id]
			render 'outgoing_trade'
		elsif @trade.recipient.id == session[:current_user_id]
			render 'incoming_trade'
		else
			# you are not involved in this trade
		end
	end

	def destroy
		@trade.destroy
		redirect_to users_path
	end

	private

	def set_trade
		@trade = Trade.find(params[:id])
	end
end
