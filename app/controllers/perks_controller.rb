require 'rqrcode'
# require 'barby'
# require 'barby/barcode'
# require 'barby/barcode/qr_code'
# require 'barby/outputter/png_outputter'

class PerksController < ApplicationController

  def index
    @product = Product.find(params[:product_id])
    @perks = @product.perks
  end

  def new
    @business = Business.find(params[:business_id])
    @product = Product.find(params[:product_id])
    @perk = Perk.new
  end

  def show
    @perk = Perk.find(params[:id])
    qrcode = RQRCode::QRCode.new("czekpass.com/users/#{current_user.id}/validate?pid=#{params[:id]}")

    @qr = qrcode.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 6
    )

     IO.write(Rails.root.join('app', 'assets', 'images', 'qrcode.svg'), @qr.to_s)
  end



  def create
    @perk = Perk.new(perk_params)
    @product = Product.find(params[:product_id])
    @business = Business.find(params[:business_id])
    @perk.business = @business
    @perk.product = @product

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
    params.require(:perk).permit(:kind, :amount, :description, :product_id)
  end
end







 # <% if Rails.env.development? %>
 #      <% qrcode = RQRCode::QRCode.new("https://38c9a5e1.ngrok.io/banks/" + @bank.id.to_s + "/verifications/" + @verification.id.to_s) %>
 #    <% else %>
 #      <% qrcode = RQRCode::QRCode.new("https://trashbounty.herokuapp.com/banks/" + @bank.id.to_s + "/verifications/" + @verification.id.to_s) %>
 #    <% end %>

 #    <% svg = qrcode.as_svg(
 #      offset: 0,
 #      color: '000',
 #      shape_rendering: 'crispEdges',
 #      module_size: 6
 #    ) %>

