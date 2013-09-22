class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def index
    @bets = Bet.all
    respond_with(@bets)
		# @bets = Bet.where(user_id: current_user.id )
  #   respond_with(@bets)
  end
end
