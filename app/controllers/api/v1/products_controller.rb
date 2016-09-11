module Api
  module V1
    class ProductsController < ApplicationController
      before_action :doorkeeper_authorize!
      respond_to :json

      def index
        respond_with Product.all
      end
    end
  end
end