class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  has_many :accounts
  has_one :googleinfo
  has_one :facebookinfo
  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #     user.public_profile = auth.info.public_profile
  #     user.user_friends = auth.info.user_friends
  # user.name = auth.info.name   # assuming the user model has a name
  # user.image = auth.info.image # assuming the user model has an image

  def fb_from_omniauth(auth)
    fb_info = self.facebookinfo || self.build_facebookinfo
    fb_info.email = auth.info.email if auth.info.has_key? 'email'
    fb_info.user = auth.info.user
    fb_info.name = auth.info.name
    fb_info.first_name = auth.info.first_name
    fb_info.last_name = auth.info.last_name
    fb_info.gender = auth.info.gender
    fb_info.image = auth.info.image
    fb_info.urls = auth.info.urls
    fb_info.uid = auth.info.uid
    fb_info.locale = auth.info.locale

    fb_info.save
  end

  def google_from_omniauth(auth)
    if self.googleinfo
      google_info = self.googleinfo
    else
      google_info = Googleinfo.new
      google_info.user_id = self.id
    end
    google_info.email = auth.info.email if auth.info.has_key? 'email'
    google_info[:user] = auth.info.user
    google_info.first_name = auth.info.first_name
    google_info.last_name = auth.info.last_name
    # google_info.gender = auth.info.gender
    # google_info.image = auth.info.image
    # google_info.urls = auth.info.urls
    # google_info.uid = auth.info.uid
    # google_info.locale = auth.info.locale

    google_info.save
    google_info
  end


end

