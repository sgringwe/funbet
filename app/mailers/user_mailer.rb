class UserMailer < ActionMailer::Base
  include SendGrid

  default from: 'bmchrist@mtu.edu'

  sendgrid_category :use_subject_lines
  sendgrid_enable   :ganalytics, :opentrack
  sendgrid_unique_args :key1 => "value1", :key2 => "value2"

  def welcome_message(user)
    sendgrid_category "Welcome"
    sendgrid_unique_args :key2 => "newvalue2", :key3 => "value3"
    mail :to => user.email, :subject => "Welcome #{user.username}"
  end

  def bet_created_message(bet)
    puts 'sending to ' + bet.user.email
    mail to: bet.user.email, subject: "That bet is a hoot!", body: 'Thanks for placing a bet! We will let you know when someone challenges you.'
  end

end
