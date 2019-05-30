class TradesController < ApplicationController

	before_action :set_trade, only: [:show, :destroy]

	def show
		if @trade.sender == current_user
			render :outgoing_trade
		elsif @trade.recipient == current_user
			render :incoming_trade
		else
			render_403
		end
	end

	def new
		redirect_if_not_logged_in
		@trade = Trade.new
		@recipient = User.find(params[:id])
	end

	def create
		@trade = Trade.create(trade_params)
		@trade.create_tbs(params[:sender_books], params[:recipient_books])

		redirect_to user_trades_path(current_user)
	end

	def destroy
		if @trade.sender == current_user || @trade.recipient == current_user
			@trade.trade_books.each(&:destroy)
			@trade.destroy
			redirect_to user_trades_path(current_user)
		else
			render_403
		end
	end

	private

	def trade_params
		params.require(:trade).permit(:sender_id, :recipient_id, :status)
	end

	def set_trade
		@trade = Trade.find(params[:id])
	end
end
