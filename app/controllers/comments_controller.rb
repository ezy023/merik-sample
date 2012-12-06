class CommentsController < ApplicationController

	def create
		commentable = Micropost.find(params[:micropost_id])
		commentable.comments.create(comment: params[:comment], user_id: current_user.id)
		commentable.save
		flash[:notice] = "Comment Posted"
		redirect_to commentable
	end

	def destroy
		com = Comment.find(params[:id])
		@post = Micropost.find(com.commentable_id)
		com.destroy
		redirect_to @post
	end

end
