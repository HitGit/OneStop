class Facebookinfo < ActiveRecord::Base
  belongs_to :user

  def get_client
    @client ||= Koala::Facebook::API.new self.token
  end

  def method_missing meth, *args
    c = get_client
    c.send meth, *args
  end
end