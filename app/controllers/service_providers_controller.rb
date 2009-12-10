class ServiceProvidersController < ApplicationController
  def index
    @service_providers = ServiceProvider.all
  end
  
  def show
    @service_provider = ServiceProvider.find(params[:id])
  end
  
  def new
    @service_provider = ServiceProvider.new
    @service_provider.services.build
  end
  
  def create
    @service_provider = ServiceProvider.new(params[:service_provider])
    if @service_provider.save
      flash[:notice] = "Successfully created service provider."
      redirect_to @service_provider
    else
      render :action => 'new'
    end
  end
  
  def edit
    @service_provider = ServiceProvider.find(params[:id])
    @service_provider.services.build if @service_provider.services.blank?
  end
  
  def update
    @service_provider = ServiceProvider.find(params[:id])
    if @service_provider.update_attributes(params[:service_provider])
      flash[:notice] = "Successfully updated service provider."
      redirect_to @service_provider
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @service_provider = ServiceProvider.find(params[:id])
    @service_provider.destroy
    flash[:notice] = "Successfully destroyed service provider."
    redirect_to service_providers_url
  end
end
