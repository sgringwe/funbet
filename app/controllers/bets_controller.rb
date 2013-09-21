class BetsController < ApplicationController
	respond_to :html

  def index
    @bets = Bet.all
		respond_with(@bets)
  end

  def show
    @bet = Bet.find(params[:id])
		respond_with(@bet)
  end

  def new
    @bet = Bet.new
		respond_with(@bet)
  end

  def edit
    @bet = Bet.find(params[:id])
		respond_with(@bet)
  end

  def create
    @bet = Bet.new(params[:bet])
		@bet.convert_bools!
		@bet.save
		redirect_to bets_path
  end

  def update
    @bet = Bet.find(params[:id])
    @bet.update_attributes(params[:bet])
		@bet.convert_bools!
		respond_with(@bet)
  end

  def destroy
    bet = Bet.find(params[:id])
    bet.destroy
		redirect_to bets_path
  end
end
