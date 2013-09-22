class BetsController < ApplicationController
	respond_to :html

	before_filter :authenticate_user!

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
    @bet = Bet.new
    @bet.proposition = params[:bet][:proposition]
    @bet.loser_task = params[:bet][:loser_task]
    @bet.is_public = params[:bet][:is_public]
    @bet.owner_id = current_user.id
		@bet.convert_bools!

		if @bet.save
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

  def complete
    choice = params[:choice]
    bet = Bet.find(params[:id])
    
    bet.outcome = choice

    bet.user_choices.each do |user_choice|
      if !(user_choice.choice === choice)
        user_choice.delivered = false
      end
    end
  end

  def agree
    @bet = Bet.find(params[:bet_id])
    u = UserChoice.new(user_id: current_user.id, bet_id: @bet.id, choice: true)
    u.save

    Send a simple sms notificatin to initialize the feedback loop
    sms = Sms.new
    sms.to_user = @bet.owner
    sms.content = 'Someone agreed with your bet on betly.io!'
    sms.deliver

    # Send a simple email
    msg = UserMailer.new_gambler_message(u)
    msg.deliver!

    redirect_to @bet
  end

  def disagree
    @bet = Bet.find(params[:bet_id])
    u = UserChoice.new(user_id: current_user.id, bet_id: @bet.id, choice: false)
    u.save

    # Send a simple sms notificatin to initialize the feedback loop
    sms = Sms.new
    sms.to_user = @bet.owner
    sms.content = 'Someone challenged you on betly.io!'
    sms.deliver

    # Send a simple email
    msg = UserMailer.new_gambler_message(u)
    msg.deliver!

    redirect_to @bet
  end

end
