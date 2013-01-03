class FavoritesController < ApplicationController
  def create
  	@post = Micropost.find(params[:favorite][:micropost_id])
	  current_user.favorite!(@post)
	  respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def destroy
    @post = Micropost.find(params[:favorite][:micropost_id])
    @fav = Favorite.find(params[:id])
    current_user.unfavorite!(@fav)
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end
end
