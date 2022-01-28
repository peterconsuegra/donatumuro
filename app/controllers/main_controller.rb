class MainController < ApplicationController
  
  layout "blank"

    def index
      @twitter_api_key = ENV["twitter_api_key"] 
      @twitter_api_secret = ENV["twitter_api_secret"] 
      @twitter_count = TwitterAccount.all.count
    end

end