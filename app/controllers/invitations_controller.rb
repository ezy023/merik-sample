class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    if @invitation.save
      UserMailer.invitation(@invitation, signup_path+"/#{@invitation.token}").deliver
      redirect_to root_url, :notice => "Thank you, invitation sent."
    else
      render :action => 'new'
    end
  end
end
