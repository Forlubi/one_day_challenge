# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'random/password'
require 'csv'
require 'open-uri'
require 'ruby-progressbar'
include RandomPassword


# define parameters
user_num = 30 # number of users in the database
challenge_num = 29 # number of challenges in the db (need to match length of google sheet)
participate_max = 5 # number of MAX actively-envolved challenges for each user
history_max = 4 # number of MAX finished challenges for each user
favorite_max = 4 # number of MAX favorite challenges for each user
# link to live google sheet of challenges in cvs format
csv_path = "https://docs.google.com/spreadsheets/d/12iXky8WcK-Lbvuxp6eeOxoL5aAlSNinPKJrisbyq_Gw/gviz/tq?tqx=out:csv"

################# fake users #################
User.delete_all
puts "Generating users..."
progress_user = ProgressBar.create(
  :title => "users", :starting_at => 0, :length => 100,
  :total => user_num, :format => '%a |%b>>%i| %p%% %t',)
user_num.times do
  progress_user.increment
  password = generate(16)
  User.create!(name: Faker::Name.name, 
               email: Faker::Internet.email, 
               password: password, 
               password_confirmation: password,
               chechin_number: rand(100),
               challenge_number: rand(50),
               coins: rand(250))
end

################# fake challenges #################
Challenge.delete_all
puts "Generating challenges..."
progress_challenge = ProgressBar.create(
  :title => "challenges", :starting_at => 0, :length => 100,
  :total => challenge_num, :format => '%a |%b>>%i| %p%% %t',)

csv = CSV.parse(open(csv_path), :headers=>true)
divide_point = challenge_num * 3 / 4
# take 3/4 challenges to be currently active challenges (deadline -> future date)
active_challenges = []
# take 1/4 challenges to be archived challenges (deadline -> past date)
archived_challenges = []
count = 0
csv.each do |row|
  progress_challenge.increment
  ddl = nil
  if count < divide_point
    # deadline to be random date from 2020/05/?? to 2020/09/??
    ddl = Faker::Date.in_date_period(year: 2020, month: 5 + rand(4))
  else
    # deadline to be random date from the past 14 days
    ddl = Faker::Date.backward(days: 14)
  end

  challenge = Challenge.create!(
    name: row["tittle"], 
    category: row["category"], 
    description: row['description'], 
    coins: row["coins"].to_i,
    participant_number: 0,
    failed_number: 0,
    duration: row["duration"].to_i,
    deadline: ddl,
    pic_link: row["pic"],
    owner_id: User.all.sample.id)

  if count < divide_point
    active_challenges << challenge
  else
    archived_challenges << challenge
  end
  count += 1
end


################# fake participate_ins, histories and favorites #################
ParticipateIn.delete_all
History.delete_all
Favorite.delete_all
puts "Generating activities for users..."
progress_activities = ProgressBar.create(
  :title => "activities", :starting_at => 0, :length => 100,
  :total => user_num, :format => '%a |%b>>%i| %p%% %t',)

def get_new_challenge used_challenges, all_challenges
  # get a new challenge from all_challenge but not in used_challenge
  challenge = all_challenges.sample
  while used_challenges.include? challenge.id
    challenge = all_challenges.sample
  end
  used_challenges << challenge.id
  return used_challenges, challenge
end

users = User.all
users.each do |user|
  progress_activities.increment
  used_challenges = []

  # create user's participate_ins
  rand(participate_max).times do
    # pick a new challenge from active_challenges
    used_challenges, challenge = get_new_challenge(used_challenges, active_challenges)
    # define ParticipateIn.failed and ParticipateIn.finished
    check_in = rand(challenge.duration + 1)
    finish = false
    fail_or_not = [true, false, false, false, false].sample
    if check_in == challenge.duration
      finish = true
      fail_or_not = false
    end
    # create corresponding participate_in object
    ParticipateIn.create!(
      user_id: user.id,
      challenge_id: challenge.id,
      continuous_check_in: check_in,
      failed: fail_or_not,
      finished: finish)
    # create corresponding activity object
    Activity.create!(
      user_id: user.id, 
      challenge_id: challenge.id, 
      relation: "Participated in")

    # update challenge.participant_number
    challenge.participant_number += 1
    # if user fail challenge, update challenge.failed_number
    if fail_or_not
      challenge.failed_number += 1
    end
    challenge.save!
  end

  # create user's favorites
  rand(favorite_max).times do
    # pick a new challenge from active_challenges
    used_challenges, challenge = get_new_challenge(used_challenges, active_challenges)
    # create corresponding favorite object
    Favorite.create!(
      user_id: user.id,
      challenge_id: challenge.id)
    # create corresponding activity object
    Activity.create!(
      user_id: user.id, 
      challenge_id: challenge.id, 
      relation: "Favorited")
  end

  # create user's histories
  rand(history_max).times do
    # pick a new challenge from active_challenges
    used_challenges, challenge = get_new_challenge(used_challenges, archived_challenges)
    # create corresponding participate_in object
    check_in = rand(challenge.duration + 1)
    History.create!(
      user_id: user.id,
      challenge_id: challenge.id,
      continuous_check_in: check_in,
      finished: check_in == challenge.duration ? true : false)
  end
end
