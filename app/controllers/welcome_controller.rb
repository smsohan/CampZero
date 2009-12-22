class WelcomeController < ApplicationController
  def index
    @service_categories = ServiceCategory.roots
  end
  
  def contact
    @title = 'Contact CampZero.com'
  end

end
