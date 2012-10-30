class RetweetingsController < ApplicationController
  before_filter :signed_in_user
  
  def create
  	@post = Micropost.find(params[:retweeting][:retweet_id])
	  current_user.retweet!(@post)
	  respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
		
  end

  def destroy
    @post = Retweeting.find(params[:id]).retweet
    current_user.untweet!(@post)
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def user
  	@post = Micropost.find(params[:retweeting][:retweet_id])
  	@post.user
  end
end
