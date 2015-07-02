Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_API_SECRET'],
           :scope => 'email, user_posts, manage_pages, publish_pages', :display => 'popup'

end