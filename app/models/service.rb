class Service < ActiveRecord::Base
  PER_PAGE = 10
  has_many :attached_files, :dependent => :destroy

  belongs_to :service_category
  belongs_to :service_provider
  belongs_to :user

  accepts_nested_attributes_for :attached_files

  define_index do
    indexes title
    indexes service_description
    has :id
    has user_id
    has service_category_id
    has created_at
    set_property :delta => true
  end

  def self.search_by_text(query, page = 1)
    services = []
    begin
      services = Service.search(query).compact.paginate(:page => page, :per_page => PER_PAGE)
    rescue Exception => error
      logger.error("Exception in service search for #{error.message} at #{error.backtrace.join}")
    end
    return services.compact || [].paginate(:page => page, :per_page => PER_PAGE)
  end
  
end
