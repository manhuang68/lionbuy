class UsersController < ApplicationController

  def index

  end

  def create
    puts "this is"
    puts user_params
    user = User.find_by(email: user_params[:email])
    puts user
    if user != nil
      flash[:notice] = 'Email already exist!'
      redirect_to "/signup" and return
    end
    if user_params[:password] != user_params[:password_confirmation]
      puts user_params[:password]
      puts user_params[:password_confirmation]
      flash[:notice] = 'Password does not match!'
      redirect_to "/signup" and return
    end

    puts "tt"
    puts user_params
    r = user_params.except(:password_confirmation)
    puts r
    user = User.new(r)
    if user.save
      session[:user_id] = user.id
      redirect_to root_url and return
    else
      flash[:notice] = user.errors.full_messages
      redirect_to "/signup" and return
    end
  end

  def signup

  end

  private
  def user_params
    params.require(:user).permit(:email, :password,:password_confirmation)
  end
end
