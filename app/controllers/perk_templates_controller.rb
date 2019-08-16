class PerkTemplatesController < ApplicationController

  def new
    @business = Business.find(params[:business_id])
    @perk_template = PerkTemplate.new
  end

  def create
    @business = Business.find(params[:business_id])
    @perk_template = PerkTemplate.new(perk_template_params)
    @perk_template.business = @business
    @perk_template.product
    if @perk_template.save
      redirect_to @business
    else
      render "new"
    end
  end

  private

  def perk_template_params
    params.require(:perk_template).permit(:kind, :amount, :description)
  end

end
