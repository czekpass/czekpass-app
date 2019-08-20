class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if current_user.nil?
      redirect_to new_user_session_path
    else
      if /admin/.match(current_user.email)
        redirect_to business_dashboard_path
      else
        redirect_to dashboard_page_path
      end
    end
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
    # @businesses = current_user.offering_businesses.geocoded
    @all_businesses = Business.geocoded

    if params[:query].present?
      sql_query = "name ILIKE :query OR location ILIKE :query"
      @businesses = current_user.offering_businesses.where(sql_query, query: "%#{params[:query]}%").geocoded
    else
      @businesses = current_user.offering_businesses.geocoded
    end


    @markers = @businesses.map do |business|
      {
        lat: business.latitude,
        lng: business.longitude,
        # This is for the pop-ups on the map
        infoWindow: render_to_string(partial: "info_window", locals: { businesses: business })
     }
    end

    # trying to get the tabs to not refresh on 'search'

    # respond_to do |format|
    #   format.html {render}
    #   format.js
    # end
  end
end


































