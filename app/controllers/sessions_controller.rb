class SessionsController < ApplicationController
  def create
    #puts login_params[:email]
    #puts "test"
    @us = User.all
    @us.each do |test|
      #puts test
      #puts test.email
      #puts test.password
    end
    if login_params[:email].empty?
      flash[:notice] = 'Email cannot be empty!'
      redirect_to "/signin" and return
    end

    if login_params[:password].empty?
      flash[:notice] = 'Password cannot be empty!'
      redirect_to "/signin" and return
    end

    user = User.find_by(email: login_params[:email])
    #puts "the us "
    if user == nil
      flash[:notice] = 'Account does not exist!'
      redirect_to "/signin" and return
    end
    if user && user.password == (login_params[:password])
      session[:user_id] = user.id
      session[:fname] = user.fname
      session[:lname] = user.lname
      session[:email] = user.email
    #  session[:image] = user.image.url(:medium)
      redirect_to root_url
    else
      flash[:notice] = 'Invalid credentials!'
      redirect_to "/signin"
    end
  end

  def destroy
    #puts "log out successfully"
    session[:user_id] = nil
    session[:fname] = nil
    session[:lname] = nil
    session[:unread_posts] = nil
    session.clear
    redirect_to "/signin"
  end

  private
  def login_params
    params.require(:login).permit(:email, :password)
  end
end
