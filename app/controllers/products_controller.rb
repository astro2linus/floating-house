class ProductsController < ApplicationController

	before_filter :authorize_view_product, only: [:show]
  before_filter :authorize_view_release, only: [:show]
	#before_filter :authorize_manage_product, only: [:edit, :update, :destroy]
	
	def index
		@products = Product.all.desc(:updated_at)
	end

	def edit
		@product = Product.find(params[:id])
	end

	def upload
		authorize! :upload, Product, message: "You are not authorized to upload products"
  end

  def update
  	@product = Product.find(params[:id])
		if @product.update_attributes(product_params)
			flash[:success] = "Product has been saved successfully"
			redirect_to products_url
		else
			render 'edit'
		end
	end

  def download
  	# Download the latest release (zip or apk) for testing
    @product = Product.find params[:id]
    @release = @product.releases.asc(:created_at).select {|r| r.extension != "ipa"}.last
    

    if @release.respond_to?(:ipa_file)
      content = @release.ipa_file.read
      send_data content, type: @release.ipa_file.content_type, :filename => @release.ipa_file
    elsif @release.respond_to?(:apk_file)
      content = @release.apk_file.read
      send_data content, type: @release.apk_file.content_type, :filename => @release.apk_file
    end
    expires_in 0, public: true
  end

	private
		def product_params
			params.require(:product).permit(:name, :description, :icon)
		end

end
