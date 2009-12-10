class ServiceProviderCategoriesController < ApplicationController
  def index
    @service_provider_categories = ServiceProviderCategory.all
  end
  
  def show
    @service_provider_category = ServiceProviderCategory.find(params[:id])
  end
  
  def new
    @service_provider_category = ServiceProviderCategory.new
  end
  
  def create
    @service_provider_category = ServiceProviderCategory.new(params[:service_provider_category])
    if @service_provider_category.save
      flash[:notice] = "Successfully created service provider category."
      redirect_to @service_provider_category
    else
      render :action => 'new'
    end
  end
  
  def edit
    @service_provider_category = ServiceProviderCategory.find(params[:id])
  end
  
  def update
    @service_provider_category = ServiceProviderCategory.find(params[:id])
    if @service_provider_category.update_attributes(params[:service_provider_category])
      flash[:notice] = "Successfully updated service provider category."
      redirect_to @service_provider_category
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @service_provider_category = ServiceProviderCategory.find(params[:id])
    @service_provider_category.destroy
    flash[:notice] = "Successfully destroyed service provider category."
    redirect_to service_provider_categories_url
  end
end
