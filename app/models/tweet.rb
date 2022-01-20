class Tweet < ApplicationRecord
  
  #belongs_to :twitter_account
  
  validates :body, length: {minimum: 1, maximun: 200}
  #validates :publish_at, presence: true
    
  def published?
    #If have question mark, it will return true or false
    tweet_id?
  end
  
  def publish_to_twitter(twitter_account)
    tweet = twitter_account.client.update(body)
    update(tweet_id: tweet.id)
  end
  
  
end
