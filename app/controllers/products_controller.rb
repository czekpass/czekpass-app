class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.business_id = current_user.id
    if @product.save
      redirect_to @product
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def delete
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products
  end

  def edit
    @business = Business.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price_cents, :category, :photo)
  end
end
