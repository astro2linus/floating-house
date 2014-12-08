class HomeController < ApplicationController
	skip_before_filter :validate_user
  def index
  end

  def install_certificate	
  end
end
