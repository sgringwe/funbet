class OutcomeDecidedWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false
  
  def perform(bet_id)
    bet = Bet.find(bet_id)
    # If no challengers, nothing. Should not even be a thing anymore
    # Send out SMS and email to all involved users on the decision.
    # If winner, congragulate.
    # If loser, tell them their task.
  end
end