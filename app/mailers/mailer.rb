class Mailer < ActionMailer::Base
  default from: ENV["GMAIL_USER"]
  def invitation(invitation, signup_url)
    @signup_url = signup_url
    # @user = user
    mail :to => invitation.recipient_email, :subject => 'Invitation'
   
    # :subject =>    'Invitation'
    # :recipients => invitation.recipient_email
    # :from =>       'foo@example.com'
    # :body =>      :invitation => invitation, :signup_url => signup_url
    invitation.update_attribute(:sent_at, Time.now)
  end
end
