class BetsController < ApplicationController
	respond_to :html

	def index
		@bets = Bet.all
		respond_with(@bets)
	end

	def show
		puts params
		@bet = Bet.find(params[:id])
		respond_with(@bet)
	end

	def new
		@bet = Bet.new
		respond_with(@bet)
	end

	def create
		@bet = Bet.new(params[:bet])
		@bet.save
		respond_with(@bet)
	end
end
