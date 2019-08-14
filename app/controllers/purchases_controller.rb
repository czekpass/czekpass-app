class PurchasesController < ApplicationController

  def index
    @purchases = Purchase.all
  end

  def show
  end

  def new
  end

  def create
  end

  private

  def purchase_params
  end
end
