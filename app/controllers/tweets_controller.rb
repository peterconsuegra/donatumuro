class TweetsController < ApplicationController
  
  before_action :require_user_logged_in!
  before_action :set_tweet, only: [:edit, :update, :destroy]
  
  def index
    @tweets = Tweet.all  
  end
  
  def new
    @tweet = Tweet.new  
  end 
  
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = Current.user.id
    if @tweet.save
      twitter_accounts = TwitterAccount.all
      
      twitter_accounts.each do |twitter_account|
        @tweet.publish_to_twitter(twitter_account)
      end
      
      redirect_to tweets_path, notice: "Tweet was schedule successfully"
    else
      render :new
    end
  end
  
  def edit
    
  end
  
  def update
    if @tweet.update(tweet_params)
      TweetJob.set(wait_until: @tweet.publish_at).perform_later(@tweet)
      redirect_to tweets_path, notice: "Tweet was updated successfully"
    else
      render :new
    end
  end
  
  def destroy
    @tweet.destroy
  end
  
  private
  
  def tweet_params
    params.require(:tweet).permit(:twitter_account_id, :body, :publish_at)
  end
  
  def set_tweet
    @tweet = Current.user.tweets.find(params[:id])
  end
  
end