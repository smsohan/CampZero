class PasswordResetsController < ApplicationController
  before_filter :load_user_by_perishable_token, :only => [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if(@user)
      @user.deliver_password_reset_instructions!
      flash[:notice] = 'Please check your email for password reset instruction.'
      render :action=>:new
    else
      flash[:error] = 'Please provide email address of your existing account to reset the password.'
      @user = User.new :email => params[:email]
      @user.errors.add :email
      render :action => :new
    end

  end

  def edit
    
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    unless(@user.save)
      flash[:error] = 'The password reset operation failed. Please try again later.'
      render :action => :edit
      return
    end
    flash[:notice] = 'The password reset process completed successfully.'
    redirect_to root_path

  end

  private
  def load_user_by_perishable_token
    @user = User.find_by_perishable_token(params[:id])
    unless(@user)
      flash[:error] = 'Please check your password reset URL and retry.'
      redirect_to root_path
      return false
    end
    
  end

end
