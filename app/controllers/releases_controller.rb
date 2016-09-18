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
		@product = Product.find(params[:product_id])
		@releases = @product.releases.desc(:updated_at)
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

  def download
    @release = Release.find(params[:id])

    if @release.respond_to?(:ipa_file)
      content = @release.ipa_file.read
      send_data content, type: @release.ipa_file.content_type, :filename => @release.ipa_file, disposition: "inline"
      expires_in 0, public: true
    elsif @release.respond_to?(:apk_file)
      content = @release.apk_file.read
      send_data content, type: @release.apk_file.content_type, :filename => @release.apk_file, disposition: "inline"
      expires_in 0, public: true
    end
  end

	private

	def class_from_controller_name
  	controller_name.singularize.camelize.constantize
	end

end
