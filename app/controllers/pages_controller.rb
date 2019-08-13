class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def business_page
    @perks = Perk.all
  end
end
