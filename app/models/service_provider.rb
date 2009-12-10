class ServiceProvider < ActiveRecord::Base
#  attr_accessible :name, :phone, :fax, :mobile, :email, :service_provider_category_id
  
  has_many :services, :dependent => :destroy

  belongs_to :service_provider_category

  accepts_nested_attributes_for :services

end
