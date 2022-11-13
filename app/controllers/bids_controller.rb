class BidsController < ApplicationController

  def index
  #  @user = User.new
  end

  def create
    #puts "this is"

  end

  def update

  end

  private
  def user_params
    params.require(:bid).permit(:amount, :product_id)
  end
end
