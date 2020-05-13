class UserMailer < ApplicationMailer
  default from: 'onedaychallenge@noreply.com'
 
  def reminder_email(user)
    @user = user
    mail(to: @user.email, subject: '[One Day Challenge] Checkin Reminder')
  end

  def welcome_email(user)
    @user = user
    #puts "####################{asset_url("/images/welcome.jpg")}"
    #attachments.inline["welcome.jpg"] = asset_url("/images/welcome.jpg")
    #attachments.inline["welcome.jpg"] = File.read(ActionController::Base.helpers.asset_path('welcome.jpg'))
    mail(to: @user.email, subject: 'Welcome to One Day Challenge!')
  end

end
