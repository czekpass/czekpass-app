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
    @purchase = Purchase.new
    @user = User.find(54) # placeholder to be replaced with qr code
    @perk = @user.perks # needs to be replaced with the instance of the perk, not all perks available!
    raise
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.user = User.find(54) # random user to replace QR code user
  end

  private

  def purchase_params
    require(:purchase).permit(:user_id, :product_id)
  end
end
