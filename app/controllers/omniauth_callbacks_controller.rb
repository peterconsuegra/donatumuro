class OmniauthCallbacksController < ApplicationController
  
   #before_action :require_user_logged_in!
  
  def twitter
    
    Rails.logger.info "Auth object from twitter"
    Rails.logger.info auth
    
    twitter_account = TwitterAccount::where(username: auth.info.nickname).first
    
    if twitter_account.nil?
      
        new_twitter_account = TwitterAccount.new 
        new_twitter_account.name = auth.info.name
        new_twitter_account.username = auth.info.nickname
        new_twitter_account.image = auth.info.image
        new_twitter_account.token = auth.credentials.token
        new_twitter_account.secret = auth.credentials.secret
        new_twitter_account.save!
     
    end
    
    redirect_to "/", notice: "Succesully connected your account"
    
  end
  
  def auth
    request.env['omniauth.auth']
  end
  
end