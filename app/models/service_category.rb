class ServiceCategory < ActiveRecord::Base
  acts_as_tree :order => :name
  has_many :services
  
  sitemap

  def to_param
    "#{self.id}-#{self.name} service Bangladesh".gsub /[^[:alnum:]]/, '-'
  end
end
