class DashboardsController < ApplicationController
  def index
		@bets = current_user.bets
  end
end
