class TradesController < ApplicationController

	before_action :set_trade, only: [:show]

	def show
		byebug
		if @trade.sender == @user
			render 'outgoing_trade'
		elsif @trade.recipient == @user
			render 'incoming_trade'
		else
			render 'outgoing_trade'
		end
	end

	private

	def set_trade
		@trade = Trade.find(params[:id])
	end
end
