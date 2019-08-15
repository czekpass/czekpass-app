class PerksController < ApplicationController
  # @scheduled_activities = ScheduledActivity.where(instructor_id: params[:id])

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
    @perk = Perk.new(perk_params)
    raise
    @perk.providing_business = Business.find(params[:business_id])
    @perk.providing_product = @product
    @perk.receiving_product_id = 69  #Rayhon filler, what to do?
    if @perk.save
      redirect_to @product
    else
      render "new"
    end
  end

  def update
    @product = Product.find(params[:product_id])
    if @product.update(product_params)
      redirect_to @product
      redirect_to business_product_path(@product.business, @product)
    else
      render 'edit'
    end
  end

  def delete
    @product = Product.find(params[:product_id])
    @perk.product.destroy
    redirect_to @business
  end

  def edit
    @perk = Perk.find(params[:id])
    @product = Product.find(params[:product_id])
  end

  private

  def perk_params
    params.require(:perk).permit(:kind, :amount, :description)
  end

end
