class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
		@bets = current_user.bets
  end
end
