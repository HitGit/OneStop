class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :accounts
  has_one :facebookinfo

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
    #fb_info.urls = auth.info.urls if auth.info.has_key? 'urls'

    fb_info.save
    return fb_info
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