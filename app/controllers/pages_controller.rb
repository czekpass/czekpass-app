class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def business_page
    # This is all perks available to the user
    @perks = current_user.perks
    raise
  end
end
