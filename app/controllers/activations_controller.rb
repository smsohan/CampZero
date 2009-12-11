class ActivationsController < ApplicationController

  def new
    @user = User.find_by_perishable_token(params[:id])
    if(@user.nil?)
      flash[:error] = 'Please double-check the URL that you provided!'
      redirect_to root_path
    end
    @user_session = UserSession.new
  end

  def create
    @user = User.find_by_perishable_token(params[:id])
    if(@user.nil?)
      flash[:error] = 'No account was found with the provided URL.'
      render :action => :new
    else
      @user.activate!
      flash[:notice] = 'Welcome to CampZero.com!'
      redirect_to root_path()
    end
    
  end

end
