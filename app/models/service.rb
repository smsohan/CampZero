class Service < ActiveRecord::Base
  has_many :attached_files, :dependent => :destroy

  belongs_to :service_category
  belongs_to :service_provider
  belongs_to :user

  accepts_nested_attributes_for :attached_files
  
end
