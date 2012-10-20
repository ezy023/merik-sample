class RetweetingsController < ApplicationController
  before_filter :signed_in_user
  
  def create
  	@post = Micropost.find(params[:retweeting][:retweet_id])
	current_user.retweet!(@post)
	redirect_to root_url
		
  end

  def destroy
  end

  def user
  	@post = Micropost.find(params[:retweeting][:retweet_id])
  	@post.user
  end
end
