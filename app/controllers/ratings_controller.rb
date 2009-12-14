class RatingsController < ApplicationController
  before_filter :login_required
  
  def create
    service = Service.find params[:service_id]
    if current_user == service.user
      flash[:error] = 'Sorry! You cannot rate your own ad!'
    else
      current_user.rate service, params[:rating]
    end
    redirect_to :back
  end

end
