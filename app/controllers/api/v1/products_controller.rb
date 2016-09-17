module Api
  module V1
    class ProductsController < ActionController::API #ApplicationController
      #before_action :doorkeeper_authorize!
      respond_to :json

      def index
        respond_with Product.all
      end
    end
  end
end