desc "This task is called by the Heroku scheduler add-on"
task :check_user_checkins => :environment do
  puts "Checking for users' checkins..."
  ParticipateIn.all.delete_if do |challenge|
    if failed?(p)
      History.create!(
        user_id: p.user_id,
        challenge_id: p.challenge_id,
        finished: false)
      Challenge.find(p.challenge_id).first.failed_number += 1
      true
    elsif finished?(p)
      History.create!(
        user_id: p.user_id,
        challenge_id: p.challenge_id,
        finished: true)
      true
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
    if failed?(p)
      History.create!(
        user_id: p.user_id,
        challenge_id: p.challenge_id,
        continuous_check_in: p.continuous_check_in,
        finished: false)
      Challenge.find(p.challenge_id).first.failed_number += 1
      p.destroy
    elsif finished?(p)
      History.create!(
        user_id: p.user_id,
        challenge_id: p.challenge_id,
        continuous_check_in: p.continuous_check_in,
        finished: true)
      p.destroy
    end
  end
end

# check if user fails to check_in a challenge
def failed? participate
  return participate.continuous_check_in == 0 || participate.updated_at.to_date != Date.today
end

# check if user already finished the challenge
def finished? participate
  duration = Challenge.find(participate.challenge_id).duration
  return participate.continuous_check_in == duration
end