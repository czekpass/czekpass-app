
class ProductsController < ApplicationController
  def index
    @business = Business.find(params[:business_id])
    @products = @business.products
  end

  def new
    @business = Business.find(params[:business_id])
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    @business = Business.find(params[:business_id])
    @product.business = @business
    if @product.save
      redirect_to business_product_path(@business, @product)
    else
      render :new
    end
  end



  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to business_product_path(@product.business, @product) #get from rails routes
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
    @product = Product.find(params[:id])
    @business = Business.find(params[:business_id])
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price_cents, :category, :photo)
  end
end
