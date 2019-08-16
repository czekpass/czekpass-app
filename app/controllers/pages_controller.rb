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
    # Might need to spoof. Or use ngrok to test

    # List is empty firs
    # Then push button that will find location, search for all businesses within range
    # render these businesses in a view below the button.

    @location_info = request.location.city

    @businesses = current_user.offering_businesses.geocoded
    @all_businesses = Business.geocoded

    if @businesses.nil?
      @markers = @businesses.map do |business|
        {
          lat: business.latitude,
          lng: business.longitude
        }
      end
    else
      @markers = @businesses.map do |business|
        {
          lat: business.latitude,
          lng: business.longitude
        }
      end
    end
  end
end
