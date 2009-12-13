# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  helper_method :current_user, :admin?
  
  protected
  def admin?
    current_user && current_user.role == User::ADMIN
  end

  def init_session
    @user_session = UserSession.new
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def login_required
    unless current_user.present?
      flash[:error] = 'Sorry! You can enter this page after you login!'
      redirect_to root_path
      return false
    end
  end

  def admin_required
    unless admin?
      flash[:error] = 'Sorry! Only admin can see this page!'
      redirect_to root_path
      return false
    end
  end

end
