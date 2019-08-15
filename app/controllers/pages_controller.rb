class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def business_dashboard
    # This is all perks available to the user
    if current_user.business.nil? == false
      @business = current_user.business
      @perks = @business.perks
    else
      redirect_to dashboard_page_path
    end
  end

  def dashboard
    @user = current_user
  end

  def discover
    @businesses = current_user.offering_businesses
  end
end
