
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]

  has_many :accounts
  has_one :facebookinfo
  has_one :twitterinfo

  def fb_from_omniauth(auth)
    fb_info = self.facebookinfo || self.build_facebookinfo
    fb_info.email = auth.info.email if auth.info.has_key? 'email'
    fb_info.user = auth.info.user
    fb_info.name = auth.info.name
    fb_info.first_name = auth.info.first_name
    fb_info.last_name = auth.info.last_name
    fb_info.gender = auth.info.gender
    fb_info.image = auth.info.image
    fb_info.uid = auth.info.uid
    fb_info.locale = auth.info.locale

    fb_info.save
    fb_info
  end

  def twitter_from_omniauth(auth)
    twt_info = self.twitterinfo || self.build_twitterinfo
    twt_info.name = auth.info.name
    twt_info.nickname = auth.info.nickname
    twt_info.location = auth.info.location if auth.info.has_key? 'location'
    twt_info.description = auth.info.description if auth.info.has_key? 'description'

    twt_info.save
    twt_info
  end
end
