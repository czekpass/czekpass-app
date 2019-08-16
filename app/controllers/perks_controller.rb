class PerksController < ApplicationController

  # def index
  #   @product = Product.find(params[:product_id])
  #   @perks = @product.perks
  # end

  def new
    @business = Business.find(params[:business_id])
    @product = Product.find(params[:product_id])
    @perk = Perk.new
  end

  def show
    @perk = Perk.find(params[:id])
  end

  def create
    @product = Product.find(params[:product_id])
    @business = Business.find(params[:business_id])
    @perk = Perk.new(perk_params)
    @perk.patronized_business = @business
    @perk.purchased_product = @product
    if @perk.save
      redirect_to business_product_path(@business, @product)
    else
      render "new"
    end
  end

  def edit
    @perk = Perk.find(params[:id])
    @product = @perk.purchased_product
    @business = @perk.patronized_business
  end

  def update
    @perk = Perk.find(params[:id])
    if @perk.update(perk_params)
      redirect_to business_product_path(@perk.patronized_business, @perk.purchased_product)
    else
      render 'edit'
    end
  end

  def delete
    @perk = Perk.find(params[:id])
    @perk.destroy
    redirect_to business_product_path(@perk.patronized_business, @perk.purchased_product)
  end

  private

  def perk_params
    params.require(:perk).permit(:kind, :amount, :description)
  end

end
