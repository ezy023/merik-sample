class ApplicationController < ActionController::Base

# adds authentication to make access to the app private
http_basic_authenticate_with name: ENV["SITE_ACCESS_NAME"], password: ENV["SITE_ACCESS_PASS"]

  protect_from_forgery
  include SessionsHelper
end
