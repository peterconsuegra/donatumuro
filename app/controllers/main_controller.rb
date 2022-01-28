class MainController < ApplicationController
  
  layout "blank"

    def index
      @user_name = ENV["GMAIL_USERNAME"]
      puts "ENV VARIABLE"
      puts @user_name
      @twitter_count = TwitterAccount.all.count
    end

end