class ReleasesController < ApplicationController
	def new
		@release = class_from_controller_name.new
	end

	def show
		@release = Release.find params[:id]
	end

	def create
		@release = class_from_controller_name.new(release_params)
		if @release.save
			flash[:success] = "release has been saved successfully"
			redirect_to product_releases_path(@release.product)
		else
			render 'new'
		end
	end

	def index
		@releases = Product.find(params[:product_id]).releases
		#@releases = Release.all
	end

	def destroy
		@release = Release.find(params[:id])
		@product = @release.product
		@release.destroy
		if @product.releases.blank?
			redirect_to products_url 
		else
			redirect_to product_releases_url(@product)
		end
	end

	private

		def release_params
			params.require(:ios_release).permit(:name, :version, :notes, :ipa_file, :icon, :plist_file)
		end

		def class_from_controller_name
    	controller_name.singularize.camelize.constantize
  	end
end
