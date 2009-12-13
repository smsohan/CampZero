class UsersController < ApplicationController
  before_filter :init_session, :only =>[:new]
  before_filter :login_required, :only => [:index, :show, :edit, :update, :destroy]
  before_filter :admin_required, :only => [:index, :destroy]

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save_without_session_maintenance
      @user.deliver_activation_instructions!
      flash[:notice] = 'Please check email and activate your account.'
      redirect_to(root_path)
    else
      flash[:error] = 'Please provide valid data to complete the signup process!'
      logger.error @user.errors.inspect
      init_session
      render :action => "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully destroyed user."
    redirect_to users_url
  end
end
