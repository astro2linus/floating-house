class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery unless: -> { request.format.json? }

  helper_method :current_user
  before_filter :validate_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end

  def current_user
    @current_user ||= User.where(_id: session[:user_id]).first
  end

  def validate_user
    unless current_user
      redirect_to login_url, alert: "Please login"
    end
  end

  def authorize_view_product
		authorize! :view, @product
	end

	def authorize_manage_product
		authorize! :manage, @product, :message => "You are not authorized to manage this product."
	end

  def authorize_view_release
		authorize! :view, @release
	end

	def authorize_manage_release
		authorize! :manage, @release
	end

end
