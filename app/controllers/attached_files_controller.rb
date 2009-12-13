class AttachedFilesController < ApplicationController
  before_filter :login_required, :only => [:new, :create, :destroy]
  
  def new
    service = Service.find(params[:service_id])
    @attached_file = service.attached_files.build
  end

  def create
    @attached_file = AttachedFile.new(params[:attached_file])
    begin
      @attached_file.save!
      flash[:notice] = 'File was successfully uploaded.'
    rescue Exception => error
      logger.error("Exception in file upload for #{error.message} at #{error.backtrace.join}")
      flash[:error] = 'File upload failed!'
    end
    redirect_to :back
  end

  def destroy
    @attached_file = AttachedFile.find(params[:id])
    begin
      @attached_file.destroy
      flash[:notice] = 'File was successfully removed.'
    rescue Exception => error
      logger.error("Exception in file remove for #{error.message} at #{error.backtrace.join}")
      flash[:error] = 'File remove failed!'
    end
    redirect_to :back
  end
  
end