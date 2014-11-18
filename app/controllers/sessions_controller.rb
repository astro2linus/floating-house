class SessionsController < ApplicationController
	protect_from_forgery :except => [:create]

  def new
  end

  def identity_login
  end

  def failure
    redirect_to :back || eflogin_url, alert: "Invalid email/password combination"
  end

  def create
  	if auth.blank?
      redirect_to :back, alert: "Cannot login"
    elsif @current_user = User.find_or_create_by_auth(auth)
	  	session[:user_id] = @current_user.id
	  	redirect_to products_url
    else
      failure
	  end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, notice: "You have logged out!"
  end

  protected

  def auth
  	request.env['omniauth.auth']
  end
  
end
