class Service < ActiveRecord::Base
  has_many :attached_files, :dependent => :destroy

  belongs_to :service_category
  belongs_to :service_provider

end
