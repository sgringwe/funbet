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
    # params[:owner_id] = current_user.id
    @bet = Bet.create(params[:bet])
		@bet.convert_bools!

		if @bet.save
      current_user.bets << @bet

			u = UserChoice.new(user_id: current_user.id, bet_id: @bet.id, choice: true)
			u.save

			# Send a simple sms notificatin to initialize the feedback loop
			sms = Sms.new
			sms.to_user = current_user
			sms.content = 'What a fun bet! We will let you who the fool is to challenge your amazing foresight.'
			sms.deliver

			# Send a simple email
			msg = UserMailer.bet_created_message(@bet)
			msg.deliver!

			redirect_to root_path
		else
			redirect_to new_bet_path
		end
  end

  def destroy
    bet = Bet.find(params[:id])
    bet.destroy
		redirect_to bets_path
  end

  # 'Joins' a bet. If passed choice=True, joins the 'For side'
  def challenge
    @challenge = UserChoice.new
    @challenge.bet_id = params[:bet_id]
    @challenge.user_id = current_user.id
    @challenge.choice = params[:choice]
    @challenge.save
  end
end
