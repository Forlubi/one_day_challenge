desc "This task is called by the Heroku scheduler add-on"
task :check_user_checkins => :environment do
  puts "Checking for users' checkins..."
  Challenges.check_user_checkin
  puts "done."
end