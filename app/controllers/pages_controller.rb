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
    @products = Product.where(business_id: current_user.business.id )
    @purchases = Purchase.where(product_id: @products.ids)
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
    # retrieving all the ids of the purchases of the current user and storing inside 'ids' var
    ids = @user.purchases.pluck(:id)
    # iterating through the ids to find all the saving instances that have the purchase_id
    @savings = ids.collect { |i| Saving.where(purchase_id: i) }.flatten
    if @savings.nil?
      @dollar_savings = @savings.select { |e| e.kind == "dollars" }

    # Get all perks purchased by the user and only retrieve discounted price

      discounted_price_perks = @user.perks.where(kind: 'percentage').where.not(product: nil).pluck(:discounted_price)
    # Sum all discount price

      @discounted_price_total = discounted_price_perks.inject(:+)
    # raise
    # all the user savings
      @saving_dollars_amount = @dollar_savings.pluck(:amount).inject(:+)
    # Get savings depending on chosen duration
    end
    if params[:saving].present?
      @total_saving = calculate_savings(params[:saving])
      # binding.pry
      respond_to do |format|
        format.html { render :dashboard }
        format.js
      end
    end

    # the user savings of the last 7 days
    # @weekly_savings = @savings.select { |e| e.created_at >= Date.today - 7 }.pluck(:amount).inject(:+)
    # the user savings of the last 30 days
    # @monthly_savings = @savings.select { |e| e.created_at >= Date.today - 30 }.pluck(:amount).inject(:+)
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

  private

  def calculate_savings(saving)
    ids = @user.purchases.pluck(:id)
    @savings = ids.collect { |i| Saving.where(purchase_id: i) }.flatten
    @calculated_savings = @savings.select { |e| e.created_at >= Date.today - saving.to_i }.pluck(:amount).inject(:+)
  end

  def welcome
  end

end
