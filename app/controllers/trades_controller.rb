class TradesController < ApplicationController

	before_action :set_trade, only: [:show, :accept, :complete, :destroy, :undo]

	def index
		@trades = Trade.all
	end

	def show
		if current_user == @trade.sender
			if @trade.status == 'pending'
				render :outgoing_trade
			elsif @trade.status == 'accepted'
				render :sender_accepted_trade
			end

		elsif current_user == @trade.recipient
			if @trade.status == 'pending'
				render :incoming_trade
			elsif @trade.status == 'accepted'
				render :recipient_accepted_trade
			end

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

	def accept
		redirect_if_not_logged_in
		if @trade.recipient == current_user
			@trade.update(status: 'accepted')
			@trade.user_books.each {|ub|
				ub.trades.each {|trade|
					if trade != @trade
						trade.trade_books.each(&:destroy)
						trade.destroy
					end
				}
			}
			redirect_to user_trades_path(current_user)
		else
			render_403
		end
	end

	def complete
		if current_user == @trade.sender
			@trade.update(sender_complete: true)
		elsif current_user == @trade.recipient
			@trade.update(recipient_complete: true)
		else
			render_403
		end

		# destroys all related user_books AND trade_books
		if @trade.sender_complete && @trade.recipient_complete
			@trade.user_books.each(&:destroy)
			destroy
		else
			redirect_to trade_path
		end
	end

	def undo
		@trade.update(status: 'pending', sender_complete: false, recipient_complete: false)
		redirect_to user_trades_path(current_user)
	end

	# destroys all related trade_books and comments
	# related user_books are left untouched
	def destroy
		redirect_if_not_logged_in
		if current_user == @trade.sender || current_user == @trade.recipient
			@trade.trade_books.each(&:destroy)
			@trade.comments.each(&:destroy)
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
