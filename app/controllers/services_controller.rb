class ServicesController < ApplicationController
  def index
    if params[:user_id]
      user = User.find params[:user_id]
      @services = user.services
      @title = "Services by #{user.name}"
    elsif params[:service_category_id]
      service_category = ServiceCategory.find params[:service_category_id]
      @services = service_category.services
      @title = "#{service_category.name} Services"
    else
      @services = Service.all
    end
    
    
  end
  
  def show
    @service = Service.find(params[:id])
  end
  
  def new
    @service = Service.new
    @service.attached_files.build
    @service.attached_files.build
    @service.attached_files.build
  end
  
  def create
    clean_empty_attached_file_attributes
    @service = Service.new(params[:service])
    @service.user = current_user
    if @service.save
      flash[:notice] = "Successfully created service."
      redirect_to @service
    else
      render :action => 'new'
    end
  end
  
  def edit
    @service = Service.find(params[:id])
  end
  
  def update
    @service = Service.find(params[:id])
    if @service.update_attributes(params[:service])
      flash[:notice] = "Successfully updated service."
      redirect_to @service
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    flash[:notice] = "Successfully destroyed service."
    redirect_to services_url
  end

  private
  def clean_empty_attached_file_attributes
    attached_file_attributes = params[:service][:attached_files_attributes]
    return if attached_file_attributes.blank?
    attached_file_attributes.each_key do |id|
      attached_file_attributes.delete(id) if attached_file_attributes[id]["file"].blank?
    end
    params[:service][:attached_files_attributes] = attached_file_attributes
  end
end
