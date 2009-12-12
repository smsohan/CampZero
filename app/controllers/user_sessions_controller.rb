class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Welcome to CampZero.com!"
      redirect_to root_url
    else
      flash[:error] = "Please provide valid login information."
      redirect_to :back
    end
  end
  
  def destroy
    @user_session = UserSession.find(params[:id])
    @user_session.destroy
    redirect_to root_url
  end
end
