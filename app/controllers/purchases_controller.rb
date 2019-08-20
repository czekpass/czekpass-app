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
  end

  def create
    @purchase = Purchase.new(purchase_params)

    perk_redeemed = Purchase.where(perk_id: purchase_params[:perk_id])

    if perk_redeemed.nil?
      @purchase.verified = true

      if @purchase.save
        # Once the purchase is complete, it should redirect to the business dashboard (purchases). We should see the new purchase.
        redirect_to root_path
      else
        # If it doesn't work... should show error messages.
        redirect_to :back
      end
    else
      # Need to change this route so that a "this perk has already been redeemed" message gets shown.
      redirect_to user_path(purchase_params[:user_id])
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:user_id, :product_id, :perk_id)
  end
end
