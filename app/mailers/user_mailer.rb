class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def reminder_email(user)
    @user = user
    mail(to: @user.email, subject: '[One Day Challenge] Checkin Reminder')
  end

  def welcome_email(user)
    @user = user
    #attachments.inline["welcome.jpg"] = File.read("app/assets/images/welcome.jpg")
    mail(to: @user.email, subject: 'Welcome to One Day Challenge!')
  end

end
