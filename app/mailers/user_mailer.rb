class UserMailer < ActionMailer::Base
  include SendGrid

  default from: 'noreply@betly.io'

  sendgrid_category :use_subject_lines
  sendgrid_enable   :ganalytics, :opentrack
  sendgrid_unique_args :key1 => "value1", :key2 => "value2"

  def welcome_message(user)
    if user and user.email
      sendgrid_category "Welcome"
      sendgrid_unique_args :key2 => "newvalue2", :key3 => "value3"
      mail :to => user.email, :subject => "Welcome #{user.username}"
    else
      puts "Failed to send email due to missing email"
    end
  end

  def bet_created_message(bet)
    if bet and bet.owner and bet.owner.email
      mail to: bet.owner.email, subject: "That bet is a hoot!", body: 'Thanks for placing a bet! We will let you know when someone challenges you.'
    else
      puts "Failed to send email due to missing email"
    end
  end

  def new_gambler_message(user_choice)
    if user_choice and user_choice.bet and user_choice.bet and user_choice.bet.owner.email
      mail to: user_choice.bet.owner.email, subject: "We have a new gambler!", body: 'Someone bet alongside you at betly.io. Come see if they agree or disagree.'
    else
      puts "Failed to send email due to missing email"
    end
  end

end
