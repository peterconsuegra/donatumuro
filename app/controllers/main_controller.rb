class MainController < ApplicationController
  
  layout "blank"

    def index
      @twitter_count = TwitterAccount.all.count
    end

end