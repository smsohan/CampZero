class ServicesController < ApplicationController
  before_filter :login_required, :only => [:edit, :update, :destroy]

  def index
    if params[:query].present? && params[:service_category_id].blank?
      @services = Service.search_by_text params[:query], params[:page]
      @title = "Services containing \"#{params[:query]}\""
    elsif params[:service_category_id]
      @service_category = ServiceCategory.find params[:service_category_id]
      @services = Service.search_by_category_id(@service_category.id, params[:page], params[:query] || '')
      @title = "#{@service_category.name} Service Providers in Bangladesh"
    elsif params[:user_id]
      user = User.find params[:user_id]
      @services = user.services.paginate :page => params[:page], :per_page => Service::PER_PAGE
      @title = "Services by #{user.name}"
    else
      @services = Service.all.paginate :page => params[:page], :per_page => Service::PER_PAGE
      @title = "All services"
    end
    
    @query_words = params[:query] ? params[:query].split(/\W/) : ''
    
  end
  
  def show
    @service = Service.find(params[:id])
    @service.increment! :visit_count
    @comment = @service.comments.new()
  end
  
  def new
    @service = Service.new
    @service.initialize_attached_files
    @service.user = User.new unless current_user
  end
  
  def create
    clean_empty_attached_file_attributes
    @service = Service.new(params[:service])
    unless current_user
      begin
        service_provider = User.login_or_create params[:service][:user_attributes]
      rescue Exception => ex
        flash[:error] = ex.message
        @service.initialize_attached_files
        render :new
        return
      end
      @service.user = service_provider
      @service.active = service_provider.active?
    else
      @service.user = current_user
    end
    if @service.save
      flash[:notice] = "Successfully created service."
      flash[:notice] += ' Please check email to activate your account' unless @service.active?
      redirect_to @service
    else
      render :action => 'new'
    end
  end
  
  def edit
    @service = Service.find(params[:id])
    unless current_user == @service.user
      flash[:error] = 'Sorry! You do not have permission to edit this ad!'
      render :show
    end
  end
  
  def update
    @service = Service.find(params[:id])
    unless current_user == @service.user
      flash[:error] = 'Sorry! You do not have permission to update this ad!'
      render :show
      return
    end
    if @service.update_attributes(params[:service])
      flash[:notice] = "Successfully updated service."
      redirect_to @service
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @service = Service.find(params[:id])
    unless current_user == @service.user
      flash[:error] = 'Sorry! You do not have permission to delete this ad!'
      render :show
    end
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
