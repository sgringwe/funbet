class Sms
  attr_accessor :content, :to_user

  def deliver
    return if not to_user
    return if not content

    number_to_send_from = '+14247723859'
    number_to_send_to = to_user.try(:phone)

    return if not number_to_send_to

    account_sid = 'AC47c76664f1abd5b417c81c972acb2291'
    auth_token = '3b558c800bf5867786126749bddeee59'
    
    client = Twilio::REST::Client.new(account_sid, auth_token)

    message  = client.account.sms.messages.create({
      :from => number_to_send_from,
      :to => number_to_send_to,
      :body => content
    })
  end
end
