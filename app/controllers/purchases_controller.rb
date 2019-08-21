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

    # Create a purchase.
    # If the perk has been redeemed, the perk has already been redeemed.

    if perk_redeemed.empty?
      @purchase.verified = true

      if @purchase.save
        perk = Perk.find(@purchase.perk_id)
        Saving.create!(amount: perk.amount, kind: perk.kind, purchase_id: @purchase.id, perk_id: perk.id)
        redirect_to business_dashboard_path
        flash[:notice] = "Purchase completed"
      else
        redirect_to validation_page_path()
        flash[:notice] = purchase.errors.full_messages.join(", ")
      end
    else
      redirect_to validation_page_path(params[:purchase][:user_id], pid:params[:purchase][:perk_id])
      flash[:notice] = "That perk has already been redeemed"
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:user_id, :product_id, :perk_id)
  end

end
