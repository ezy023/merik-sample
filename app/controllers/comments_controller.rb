class CommentsController < ApplicationController

	def create
		commentable = Micropost.find(params[:micropost_id])
		commentable.comments.create(comment: params[:comment], user_id: current_user.id)
		commentable.save
		flash[:notice] = "Comment Posted"
		redirect_to commentable
	end

	def destroy
	end

end
