class WelcomeController < ApplicationController
  def index
    @service_categories = ServiceCategory.roots
#    add_crumb "Home", '/'
  end
  
  def contact
    @title = 'Contact CampZero.com'
    add_crumb "Home", '/'
    add_crumb 'Contact'
  end

end
