class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:success] = "Signed in Successfully"
      sign_in authentication.user
      redirect_to root_url
    elsif current_user
      current_user.authentications.create!(provider: omniauth['provider'], uid: omniauth['uid'])
      flash[:success] = "Authentication successful."
      redirect_to authentications_url
    else
      user = User.new
      user.authentications.build(provider: omniauth['provider'], uid: omniauth['uid'])
        if user.save
          flash[:notice] = "Signed in Successfully"
          sign_in authentication.user
          redirect_to root_url
        else
          session[:omniauth] = omniauth.except('extra')
          flash[:notice] = "In order to sign in through Twitter, you must link it to your Muserik account in 'Settings'"
          redirect_to signup_path
        end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end
end
