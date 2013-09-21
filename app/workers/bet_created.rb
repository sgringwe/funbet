class BetCreatedWorker
  include Sidekiq::Worker
  require 'twilio-ruby'
  sidekiq_options queue: "high"
  # sidekiq_options retry: false
  
  def perform(bet_id)
    bet = Bet.find(bet_id)
    proposer = User.find(user_choice.bet.user)

    @account_sid = 'AC47c76664f1abd5b417c81c972acb2291'
    @auth_token = # your authtoken here
     
    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)

    @account = @client.account
    @message = @account.sms.messages.create({:from => '+14247723859', :to => '+12314925380', :body => 'A homie created a bet. See it at BET_PATH'})
    
    # Send out an email and sms to the proposer informing them that they have a challenger
  end
end