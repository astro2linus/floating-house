class SessionsController < ApplicationController
	protect_from_forgery :except => [:create]

  def new
  end

  def failure
    redirect_to login_url, alert: "Invalid email/password combination"
  end

  def create
  	if @current_user = User.find_or_create_by_auth(auth)
	  	session[:user_id] = @current_user.id
	  	redirect_to root_url, notice: "Signed in!"
	  end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to login_url, notice: "You have logged out!"
  end

  protected

  def auth
  	request.env['omniauth.auth']
  end
  
end
