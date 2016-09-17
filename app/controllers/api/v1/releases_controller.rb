module Api
  module V1
    class ReleasesController < ActionController::API
      respond_to :json
      
      def show
        @release = Release.find params[:id]
        respond_with @release
      end

      def create
        @release = class_from_controller_name.new(release_params)
        respond_with @release if @release.save
      end

      def index
        @product = Product.find(params[:product_id])
        @releases = @product.releases
        respond_with @releases
      end

      private

        def class_from_controller_name
          controller_name.singularize.camelize.constantize
        end
    end
  end
end