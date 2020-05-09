desc "This task is called by the Heroku scheduler add-on"
task :check_user_checkins => :environment do
  puts "Checking for users' checkins..."
  Challenge.check_user_checkin
  puts "done."
end

task :remind_user_checkin => :environment do
  puts "Reminding user to checkin..."
  UserMailer.reminder_email(User.where(email: "anyanxie@outlook.com").first).deliver
  #Challenge.remind_user_checkin
  puts "done."
end