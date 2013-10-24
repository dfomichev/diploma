class AdminController < ApplicationController
  helper_method :logged_in?

  before_filter :authenticate

  def logged_in?
     session[:login]
  end

  def index
  end
  

  protected

    def authenticate
      login = authenticate_or_request_with_http_basic do |username, password|
        username == "admin" && password == "admin"
      end
      session[:login] = login
    end

end
