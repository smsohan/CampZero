class ServiceCategory < ActiveRecord::Base
  acts_as_tree :order => :name
  has_many :services

  def to_param
    "#{self.id}-#{self.name} service providers in Bangladesh".gsub /[^[:alnum:]]/, '-'
  end
end
