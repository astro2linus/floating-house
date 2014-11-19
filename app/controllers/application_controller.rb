class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  before_filter :validate_user

  def current_user
  	@current_user ||= User.where(_id: session[:user_id]).first
  end

  def validate_user
    unless current_user
      redirect_to root_url, alert: "Please login"
    end
  end

  def authorize_view_product
		authorize! :view, @product
	end

	def authorize_manage_product
		authorize! :manage, @product
	end

  def authorize_view_release
		authorize! :view, @release
	end

	def authorize_manage_release
		authorize! :manage, @release
	end
end
