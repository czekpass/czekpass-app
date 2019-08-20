class UsersController < ApplicationController

  def index
    @users = User.all
  end


  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def delete
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users
  end

  def edit
    @user = User.find(params[:id])
  end

  def validate
    @user = User.find(params[:id])
    @perk = Perk.find(params[:pid])
    @product = @perk.product
    @product_ids = @user.products
    @validated = @product_ids.include?(@perk.purchased_product)
  end


  def user_params
    params.require(:user).permit(:email, :encrypted_password, :first_name, :last_name, :photo)
  end
end


