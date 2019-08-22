class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if current_user.nil?
      redirect_to new_user_session_path
    else
      if current_user.admin
        redirect_to business_dashboard_path
      else
        redirect_to discover_path
      end
    end
  end

  def business_dashboard
    # step 1 define purchases in instance variable
    @product_purchases = # NEED TO DEFINE
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

    # @location_info = request.location.city
    # @businesses = current_user.offering_businesses.geocoded
    @all_businesses = Business.geocoded

    sql_query = "name ILIKE :query OR location ILIKE :query"
    if params[:query].present?
      if current_user.offering_businesses.where(sql_query, query: "%#{params[:query]}%").empty? && current_user.offering_businesses.near(params[:query], 1000).geocoded.empty?
        @businesses = current_user.offering_businesses.geocoded
      end

      if current_user.offering_businesses.where(sql_query, query: "%#{params[:query]}%").empty? && !current_user.offering_businesses.near(params[:query], 1000).geocoded.empty?
        @businesses = current_user.offering_businesses.near(params[:query], 1000).geocoded
      end

      if !current_user.offering_businesses.where(sql_query, query: "%#{params[:query]}%").empty?
        @businesses = current_user.offering_businesses.where(sql_query, query: "%#{params[:query]}%")
      end
    else
      @businesses = current_user.offering_businesses.geocoded
      # redirect_to discover_path
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


































