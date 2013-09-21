class TaskDeliveredWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false
  
  def perform(user_choice_id)
    bet = Bet.find(bet_id)
    # Send out messages to all users other than delivering user that the user has delivered their loser task verification
  end
end