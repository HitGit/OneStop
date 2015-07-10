class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
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
    # fb_info.urls = auth.info.urls
    fb_info.uid = auth.info.uid
    fb_info.locale = auth.info.locale

    fb_info.save
    fb_info
  end

  def twitter_from_omniauth(auth)
    raise auth
  end
end


  # class User < ActiveRecord::Base
  #   def self.new_with_session(params, session)
  #     super.tap do |user|
  #       if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
  #         user.email = data["email"] if user.email.blank?
  #       end
  #     end
  #   end
  # end
