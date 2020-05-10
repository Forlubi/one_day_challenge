desc "This task is called by the Heroku scheduler add-on"
task :check_user_checkins => :environment do
  puts "Checking for users' checkins..."
  ParticipateIn.all.delete_if do |challenge|
    finished = finished?(challenge) 
    if failed?(challenge) || finished
      History.create!(
        user_id: challenge.user_id,
        challenge_id: challenge.challenge_id,
        finished: finished)
      true # mark for deletion
    end
  end
  puts "done."
end

task :remind_user_checkin => :environment do
  puts "Reminding user to checkin..."
  ParticipateIn.all.each do |challenge|
    if failed?(challenge)
      UserMailer.reminder_email(User.find(challenge.user_id)).deliver
    end
  end
  puts "done."
end

task :simulate_reminder => :environment do
  puts "[simulation] Sending reminder to anyanxie@outlook.com..."
  UserMailer.reminder_email(User.where(email: "anyanxie@outlook.com").first).deliver
end

task :simulate_welcome => :environment do
  puts "[simulation] Sending welcome to anyanxie@outlook.com..."
  UserMailer.welcome_email(User.where(email: "anyanxie@outlook.com").first).deliver
end

task :simulate_check_user_checkins => :environment do
  puts "[simulation] Checking Anyan's checkins for today"
  participates = User.where(email: "anyanxie@outlook.com").first.participate_ins
  participates.each do |p|
    finished = finished?(p) 
    if failed?(p) || finished
      History.create!(
        user_id: p.user_id,
        challenge_id: p.challenge_id,
        finished: finished)
      p.destroy
    end
  end
end