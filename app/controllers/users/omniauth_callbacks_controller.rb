class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    # @user = User.from_omniauth(request.env["omniauth.auth"])
    # fbinfo = current_user.fb_from_omniauth(request.env["omniauth.auth"])
    googleinfo = current_user.google_from_omniauth(request.env["omniauth.auth"])
    if !googleinfo.errors.any?
      sign_in_and_redirect current_user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => ":google_oauth2") if is_navigational_format?
    else
      session["devise.:google_oauth2_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end


  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    fbinfo = current_user.fb_from_omniauth(request.env["omniauth.auth"])

    if !fbinfo.errors.any?
      sign_in_and_redirect current_user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end


  def twitter
    twtinfo = current_user.twitter_from_omniauth(request.env["omniauth.auth"])

    if !twtinfo.errors.any?
      sign_in_and_redirect current_user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    else
      saved = request.env['omniauth.auth']
      saved.delete 'extra'
      session["devise.twitter_data"] = saved
      redirect_to new_user_registration_url
    end
  end
end
