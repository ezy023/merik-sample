class ApplicationController < ActionController::Base

# adds authentication to make access to the app private
 http_basic_authenticate_with :name => "allowed", password: "MasterChief"

  protect_from_forgery
  include SessionsHelper
end
