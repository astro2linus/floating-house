module Api
  module V1
    class ProductsController < ActionController::API #ApplicationController
      #before_action :doorkeeper_authorize!
      respond_to :json

      def index
        respond_with Product.all.desc(:updated_at)
      end

      def download
        @product = Product.find params[:id]
        @release = @product.releases.asc(:created_at).last

        if @release.respond_to?(:ipa_file)
          content = @release.ipa_file.read
          send_data content, type: @release.ipa_file.content_type, :filename => @release.ipa_file
        elsif @release.respond_to?(:apk_file)
          content = @release.apk_file.read
          send_data content, type: @release.apk_file.content_type, :filename => @release.apk_file
        end
        expires_in 0, public: true
      end

    end
  end
end