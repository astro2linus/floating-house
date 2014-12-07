class ProductsController < ApplicationController

	before_filter :authorize_view_product, only: [:show]
  before_filter :authorize_view_release, only: [:show]
	before_filter :authorize_manage_product, only: [:edit, :update, :destroy, :upload]
	
	def index
		@products = Product.all
	end

	def edit
		@product = Product.find(params[:id])
	end

	def upload	
  end

end
