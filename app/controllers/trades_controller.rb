class TradesController < ApplicationController

	before_action :set_trade, only: [:show, :destroy]

	def show
		if @trade.sender.id == session[:current_user_id]
			render 'outgoing_trade'
		elsif @trade.recipient.id == session[:current_user_id]
			render 'incoming_trade'
		else
			render(file: 'public/403', status: 403, layout: false)
		end
	end

	def destroy
		if @trade.sender.id == session[:current_user_id] || @trade.recipient.id == session[:current_user_id]
			@trade.destroy
			redirect_to user_trades_path(session[:current_user_id])
		else
			render(file: 'public/403', status: 403, layout: false)
		end
	end

	private

	def set_trade
		@trade = Trade.find(params[:id])
	end
end
