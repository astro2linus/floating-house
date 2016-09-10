class ProductsController < ApplicationController

	before_filter :authorize_view_product, only: [:show]
  before_filter :authorize_view_release, only: [:show]
	#before_filter :authorize_manage_product, only: [:edit, :update, :destroy]
	
	def index
		@products = Product.all
	end

	def edit
		@product = Product.find(params[:id])
	end

	def upload
		# authorize! :upload, Product, message: "You are not authorized to upload products"
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

	private
		def product_params
			params.require(:product).permit(:name, :description, :icon)
		end

end
