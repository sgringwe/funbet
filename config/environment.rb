# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Funbet::Application.initialize!

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  # :user_name => "yourSendGridusernameyougetfromheroku",
  # :password => "yourSendGridpasswordyougetfromheroku",
  # :domain => "staging.freelanceful.com",
  # :address => "smtp.sendgrid.net",
  # :port => 587,
  # :authentication => :plain,
  # :enable_starttls_auto => true

  :address => "smtp.sendgrid.net",
  :port => 25,
  :domain => "betly.io",
  :authentication => "plain",
  :user_name => "bmchrist",
  :password => "*mBy8Vb4sHgSYvUN"
}
