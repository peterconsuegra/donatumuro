class TwitterAccount < ApplicationRecord

  has_many :tweets, :dependent => :destroy  
  validates :username, uniqueness: true
  
  def client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        =  ENV["twitter_api_key"] #Rails.application.credentials.dig(:twitter, :api_key)
      config.consumer_secret     =  ENV["twitter_api_secret"] #Rails.application.credentials.dig(:twitter, :api_secret)
      config.access_token        = token
      config.access_token_secret = secret
    end
  end
  
end
