class Challenge < ApplicationRecord
  has_many :participate_ins
  has_many :users, through: :participate_ins
  has_many :favorites
  has_many :fav_users, through: :favorites, source: :user
  has_many :histories
  has_many :his_users, through: :histories, source: :user
  has_many :comments, dependent: :destroy

  has_one_attached :image
  has_one_attached :video

  validates :name, :category, :description, :coins, :duration, :deadline, :presence => true
  validates :name, :uniqueness => { :case_sensitive => false }

  def check_user_checkin
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
  end

  def remind_user_checkin
    # ParticipateIn.all.each do |challenge|
    #   if failed?(challenge)
    #     UserMailer.reminder_email(User.find(challenge.user_id)).deliver
    #   end
    # end
    
    # sending email testing
    UserMailer.reminder_email(User.where(email: "anyanxie@outlook.com")).deliver
  end

end
