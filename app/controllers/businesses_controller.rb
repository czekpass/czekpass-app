class BusinessesController < ApplicationController
  def index
    @businesses = Business.all
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)
    @business.user_id = current_user.id
    @business.business_category_id = params[:business][:business_category]
    if @business.save
      redirect_to @business
    else
      # New should be in quotes not a key
      render "new"
    end
  end

  def show
    @business = Business.find(params[:id])
    @user = current_user
  end

  def update
    @business = Business.find(params[:id])
    if @business.update(business_params)
      redirect_to @business
    else
      render 'edit'
    end
  end

  def delete
    @business = Business.find(params[:id])
    @business.destroy
    redirect_to businesses
  end

  def edit
    @business = Business.find(params[:id])
  end

  def new_connection
    # @business = Business.new
    @businesses = Business.all
    @business = Business.find(params[:id])
    # @selected_business = Business.find(params[:business_id])
    @products = @business.products
  end

  def filter_new_connection
    @business = Business.find(params[:business_id])
    @products = @business.products
    respond_to do |format|
        format.html { redirect_to business_connection_path(business_id: params[:business_id]) }
        format.js
      end

  end

  def business_params
    params.require(:business).permit(:location, :name, :description, :logo)
  end
end
