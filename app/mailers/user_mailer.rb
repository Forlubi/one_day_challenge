class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def reminder_email(user)
    @user = user
    #@url  = 'http://example.com/login'
    mail(to: @user.email, subject: '[One Day Challenge] Checkin Reminder')
  end
end
