class NewGamblerWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false
  
  def perform(user_choice_id)
    user_choice = UserChoice.find(user_choice_id)
    proposer = User.find(user_choice.bet.user)
    
    # Send out an email and sms to the proposer informing them that they have a challenger
  end
end