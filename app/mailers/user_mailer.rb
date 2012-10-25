class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
  	@user = user
  	mail :to => user.email, :subject => "Password Reset"
    
  end

  def contact_us(message)
    @message = message
    # @user = user
    mail :to => ENV["GMAIL_USER"], :subject => "Muserik Feedback"
  end

  def advertise_with_us(message)
    @message = message
    # @user = user
    mail :to => ENV["GMAIL_USER"], :subject => "Muserik Advertising"
  end
end
