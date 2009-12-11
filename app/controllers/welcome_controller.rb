class WelcomeController < ApplicationController
  def index
    @service_categories = ServiceCategory.roots
  end

end
