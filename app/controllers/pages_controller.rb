class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def business_dashboard
    # This is all perks available to the user
    @business = current_user.business
    @perks = @business.perks
  end

  def dashboard
    @user = current_user
  end

  def discover
    @businesses = current_user.offering_businesses
  end
end
