class ServiceCategory < ActiveRecord::Base
  acts_as_tree :order => :name
  has_many :services
end
