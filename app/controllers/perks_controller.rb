require 'rqrcode'

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

    if request.referer.include?("new_connection")
      @business = Business.find(params[:business_id])
      valid = true
      errors = []
      params["perk"].each do |p|
        unless p["product_id"].empty?
          @perk = Perk.new
          @perk.product = Product.find(p[:product_id])
          @perk.business = @business
          @perk.patronized_business = Business.find(p[:patronized_business_id])
          @perk.purchased_product = Product.find(p[:purchased_product_id])
          @perk.description = p[:description]
          @perk.kind = p[:kind]
          @perk.amount = p[:amount]
          valid = false if !@perk.save
          errors << @perk.errors.full_messages
        end
      end
      if valid
        redirect_to business_dashboard_path
        flash[:notice] = "Perks created successfully!"
      else
        redirect_to "/businesses/#{@business.id}/new_connection?bid=#{params['perk'].first[:patronized_business_id]}"

        newline_errors = errors.join(", ")
        flash[:notice] = "#{newline_errors}"
      end
    else
      @perk = Perk.new(perk_params_no_referrer)
      @perk.patronized_business_id = params[:perk][:business]
      @perk.purchased_product_id = params[:perk][:purchased_product_id]
      @perk.product_id = params[:perk][:product_id]
      @perk.discounted_price = params[:perk][:amount]
      @business = Business.find(params[:business_id])
      @perk.business_id = @business.id
      if @perk.save
        redirect_to business_dashboard_path
      end
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

  def destroy
    @perk = Perk.find(params[:id])
    @perk.destroy
    redirect_to business_dashboard_path
  end

  private

  def perk_params
    params.require(:perk).map do |p|
      p.permit(:kind, :purchased_product_id, :amount, :product_id, :description, :business_id, :patronized_business_id)
    end
  end

  def perk_params_no_referrer
    params.require(:perk).permit(:kind, :purchased_product_id, :amount, :product_id, :description, :business_id, :patronized_business_id)
  end
end
