class PasswordResetsController < ApplicationController
  skip_before_filter :authenticate
  before_filter :initialize_user_session
  before_filter :load_user_by_perishable_token, :only => [:edit, :update]
  layout 'public'

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if(@user)
      @user.deliver_password_reset_instructions!
      flash[:notice] = flash_message(:password_reset_instruction)
      render :action=>:new
    else
      flash[:notice] = flash_message(:password_reset_missing_email)
      @user = User.new :email => params[:email]
      @user.errors.add :email
      render :action => :new
    end

  end

  def edit
    flash[:notice] = ''
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    unless(@user.save)
      flash[:notice] = flash_message(:password_reset_failed)
      render :action => :edit
      return
    end
    flash[:notice] = flash_message(:password_reset_completed)
    redirect_to user_dashboard_path(@user)

  end

  private
  def load_user_by_perishable_token
    @user = User.find_by_perishable_token(params[:id])
    unless(@user)
      flash[:notice] = flash_message(:password_reset_invalid_url)
      redirect_to login_path
    end
    
  end

end
