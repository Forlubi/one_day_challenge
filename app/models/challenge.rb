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
end
