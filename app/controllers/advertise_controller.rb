class AdvertiseController < ApplicationController
  def new
    @message = Advertise.new
  end

  def create
    @message = Advertise.new(params[:message])
    if @message.valid?
      UserMailer.advertise_with_us(@message).deliver
      redirect_to root_url, notice: "Message sent! Thanks for your feedback!"
    else
      render "new"
    end
  end
end
