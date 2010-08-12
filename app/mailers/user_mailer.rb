class UserMailer < ActionMailer::Base
  default :from => "noreply@example.com"
  
  def password_reset(user, password)
    @login = user.login
    @password = password
    mail(:to => user.email, :subject => "Your Password Has Been Reset")
  end
end
