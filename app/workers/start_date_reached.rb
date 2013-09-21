class StartDateREachedWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false
  
  def perform(bet_id)
    bet = Bet.find(bet_id)
    # If the bet was challenged, send out an message to all users who made choices telling them that the 'event' is starting
    # If no challenger, inform proposer of the bad news
  end
end