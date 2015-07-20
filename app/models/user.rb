class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :twitter]

  has_many :accounts
  has_one :googleinfo
  has_one :facebookinfo
  has_one :twitterinfo

  def fb_from_omniauth(auth)
    fb_info = self.facebookinfo || self.build_facebookinfo
    fb_info.email = auth.info.email if auth.info.has_key? 'email'
    fb_info.user = auth.info.user if auth.info.has_key? 'user'
    fb_info.name = auth.info.name if auth.info.has_key? 'name'
    fb_info.first_name = auth.info.first_name if auth.info.has_key? 'first_name'
    fb_info.last_name = auth.info.last_name if auth.info.has_key? 'last_name'
    fb_info.gender = auth.extra.raw_info.gender if auth.extra.raw_info.has_key? 'gender'
    fb_info.image = auth.info.image if auth.info.has_key? 'image'
    fb_info.uid = auth.uid if auth.has_key? 'uid'
    fb_info.locale = auth.extra.raw_info.locale if auth.extra.raw_info.has_key? 'locale'
    fb_info.token = auth.credentials.token
    #fb_info.urls = auth.info.urls if auth.info.has_key? 'urls'

    fb_info.save
    fb_info
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

  def twitter_from_omniauth(auth)
    twt_info = self.twitterinfo || self.build_twitterinfo
    twt_info.name = auth.info.name
    twt_info.nickname = auth.info.nickname
    twt_info.location = auth.info.location if auth.info.has_key? 'location'
    twt_info.description = auth.info.description if auth.info.has_key? 'description'
    twt_info.token = auth.credentials.token
    twt_info.secret = auth.credentials.secret
    twt_info.save
    twt_info
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
