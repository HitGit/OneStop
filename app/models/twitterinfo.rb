class Twitterinfo < ActiveRecord::Base
  belongs_to :user

  def get_client
    @client ||= Twitter::REST::Client.new do |config|
      config.access_token = self.token
      config.access_token_secret = self.secret
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
    end
  end

  def method_missing meth, *args
    c = get_client
    c.send meth, *args
  end
end
