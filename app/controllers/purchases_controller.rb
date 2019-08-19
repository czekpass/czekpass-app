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
    @purchase.verified = true
    if @purchase.save
      perk = Perk.find(@purchase.perk_id)
      Saving.create!(amount: perk.amount, kind: perk.kind, purchase_id: @purchase.id, perk_id: perk.id)
      redirect_to root_path
    else
      redirect_to :back
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:user_id, :product_id, :perk_id)
  end
end
