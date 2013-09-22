class BetsController < ApplicationController
	respond_to :html

	before_filter :authenticate_user!

  def index
    # @bets = Bet.all
		# respond_with(@bets)
    redirect_to root_path
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
			sms.content = 'What a fun bet! We will let you know who the fool is to challenge your amazing foresight.'
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
    choice = if params[:choice] == 'true' then true else false end
    bet = Bet.find(params[:bet_id])
    
    bet.outcome = choice
    bet.convert_bools!
    bet.save

    bet.user_choices.each do |user_choice|
      if user_choice.choice != bet.outcome
        user_choice.has_delivered = false

        # Send a simple sms notificatin to initialize the feedback loop
        sms = Sms.new
        sms.to_user = user_choice.user
        sms.content = "Uh oh! Looks like you lost the #{bet.proposition} bet. Go to betly.io to see your task."
        sms.deliver

        # Send a simple email
        msg = UserMailer.incorrect_choice_message(user_choice)
        msg.deliver!
      else
        # Send a simple sms notificatin to initialize the feedback loop
        sms = Sms.new
        sms.to_user = user_choice.user
        sms.content = "Congragulations! Your bet on #{bet.proposition} was correct. Wait for task verifications to show up on betly.io."
        sms.deliver

        # Send a simple email
        msg = UserMailer.correct_choice_message(user_choice)
        msg.deliver!
      end
    end

    redirect_to bet
  end

  def agree
    @bet = Bet.find(params[:bet_id])
    u = UserChoice.new(user_id: current_user.id, bet_id: @bet.id, choice: true)
    u.save

    # Send a simple sms notificatin to initialize the feedback loop
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

  def verify
    @bet = Bet.find(params[:bet_id])
    respond_with(@bet)
  end

  def upload_verification
    @bet = Bet.find(params[:bet_id])
    @user_choice = UserChoice.where(bet_id: @bet.id, user_id: current_user.id).first
    file = params[:bet][:verification_file]
    result = Bet.upload(file.tempfile, file.original_filename, content_type: file.content_type)
    @user_choice.verification_file = {"name" => result["name"], "__type" => "File"}
    @user_choice.has_delivered = true
    s = @user_choice.save

    # Let everyone know
    @bet.user_choices.each do |user_choice|
      # Send a simple sms notificatin to initialize the feedback loop
      sms = Sms.new
      sms.to_user = user_choice.user
      sms.content = "Hilarious! #{current_user.username} has uploaded a photo executing his loser task. Check it out."
      sms.deliver

      # Send a simple email
      msg = UserMailer.verification_added_message(user_choice, current_user)
      msg.deliver!
    end

    redirect_to @bet
  end

end
