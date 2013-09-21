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

  def create
    # First create ans ave the bet
    params[:user_id] = current_user.id
    @bet = Bet.new(params[:bet])
    @bet.user_id = current_user.id
		@bet.convert_bools!
		@bet.save

    # Send a simple sms notificatin to initialize the feedback loop
    # sms = Sms.new
    # sms.to_user = current_user
    # sms.content = 'What a fun bet! We will let you who the fool is to challenge your amazing foresight.'
    # sms.deliver

    # Send a simple email
    puts 'bet user id is'
    puts @bet.user_id
    msg = UserMailer.bet_created_message(@bet)
    msg.deliver!

    # Redirect back to the list
		redirect_to bets_path
  end

  def destroy
    bet = Bet.find(params[:id])
    bet.destroy
		redirect_to bets_path
  end
end
