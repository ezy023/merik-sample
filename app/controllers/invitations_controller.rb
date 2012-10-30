class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    if @invitation.save
      if signed_in?
        Mailer.invitation(@invitation, signup_url(@invitation.token)).deliver
        redirect_to root_url, :notice => "Thank you, invitation sent."
      else
        redirect_to root_url, :notice => "Thank you for your interest. We will notify you when we are ready."
      end
    else
      render :action => 'new'
    end
  end
end
