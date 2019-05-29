class TradesController < ApplicationController

	before_action :set_trade, only: [:show, :destroy]

	def show
		if @trade.sender == current_user
			render 'outgoing_trade'
		elsif @trade.recipient == current_user
			render 'incoming_trade'
		else
			render_403
		end
	end

	def destroy
		if @trade.sender == current_user || @trade.recipient == current_user
			@trade.destroy
			redirect_to user_trades_path(current_user)
		else
			render_403
		end
	end

	private

	def set_trade
		@trade = Trade.find(params[:id])
	end
end
