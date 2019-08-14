class PurchasesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @purchases = @user.purchases
  end

  def show
    # @user = User.find(params[:user_id])
    # @product = Product.find(params[:id])
  end

# def validation
    # either boolean
    # or
    # reroute
#  end

  def new
    @user = User.find(params[:user_id])
    @product = @user.products(params[:id])

  end

  def create
  end

  private

  def purchase_params
  end
end
