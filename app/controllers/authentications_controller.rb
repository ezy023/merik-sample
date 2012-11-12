class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in Successfully"
      sign_in authentication.user
      redirect_to root_url
    else
      current_user.authentications.create(provider: omniauth['provider'], uid: omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end
end
