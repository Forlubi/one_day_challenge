class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:twitter, :github] #, :google_oauth2]

  has_many :participate_ins
  has_many :challenges, through: :participate_ins
  has_many :favorites
  has_many :fav_challenges, through: :favorites, source: :challenge
  has_many :histories
  has_many :his_challenges, through: :histories, source: :challenge
  has_many :comments, dependent: :destroy

  has_one_attached :avatar

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = provider_data.info.name
      # user.skip_confirmation!
    end
  end

  before_save { email.downcase! }
  validates :name, presence: true, uniqueness: true, length: {maximum: 50}

end
