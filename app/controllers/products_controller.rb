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
    @business = Business.find(params[:business_id])
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    @business = Business.find(params[:business_id])
    @product.business = @business
    if @product.save
      redirect_to business_dashboard_path
    else
      render :new
    end
  end


  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to business_dashboard_path #get from rails routes
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.delete
    redirect_to business_dashboard_path
  end

  def edit
    @product = Product.find(params[:id])
    @business = Business.find(params[:business_id])
  end


  # def price
  #   @product = Product.find(params[:id])
  #   @product.price
  # end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category, :photo)
  end
end
