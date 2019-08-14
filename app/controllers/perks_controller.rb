class PerksController < ApplicationController
  def show
    @perk = Perk.find(params[:id])
  end
end
