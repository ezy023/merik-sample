class PrivateMessagesController < ApplicationController
  
  before_filter :set_user
  
  def index
    if params[:mailbox] == "sent"
      @private_messages = @user.sent_messages
    else
      @private_messages = @user.received_messages
    end
  end
  
  def show
    @private_message = PrivateMessage.read_message(params[:id], current_user)
  end
  
  def new
    @private_message = PrivateMessage.new

    if params[:reply_to]
      @reply_to = @user.received_messages.find(params[:reply_to])
      unless @reply_to.nil?
        @private_message.to = @reply_to.sender.username
        @private_message.subject = "Re: #{@reply_to.subject}"
        @private_message.body = "\n\n*Original message*\n\n #{@reply_to.body}"
      end
    end
  end
  
  def create
    @private_message = PrivateMessage.new(params[:private_message])
    @private_message.sender = @user
    @private_message.recipient = User.find_by_username(params[:private_message][:to])

    if @private_message.save
      flash[:notice] = "Message sent"
      redirect_to user_private_messages_path(@user)
    else
      render :action => :new
    end
  end
  
  def delete_selected
    if request.post?
      if params[:delete]
        params[:delete].each { |id|
          @private_message = PrivateMessage.find(:first, :conditions => ["private_messages.id = ? AND (sender_id = ? OR recipient_id = ?)", id, @user, @user])
          @private_message.mark_deleted(@user) unless @private_message.nil?
        }
        flash[:notice] = "Messages deleted"
      end
      redirect_to :back
    end
  end
  
  private
    def set_user
      @user = current_user
    end
end