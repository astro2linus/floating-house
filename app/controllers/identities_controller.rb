class IdentitiesController < ApplicationController
  skip_before_filter :validate_user
  def new
    @identity = env['omniauth.identity']
  end
end
