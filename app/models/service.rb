class Service < ActiveRecord::Base
  PER_PAGE = 10
  has_many :attached_files, :dependent => :destroy

  belongs_to :service_category
  belongs_to :service_provider
  belongs_to :user

  accepts_nested_attributes_for :attached_files
  accepts_nested_attributes_for :user

  after_create :generate_permalink, :send_activation_email

  acts_as_rateable
  acts_as_commentable


    

  define_index do
    indexes title
    indexes service_description
    has :id
    has user_id
    has service_category_id
    has created_at
    indexes service_category(:name), :as => :category
    indexes user(:name), :as => :provider
    has :active
    has :average_rating
    set_property :delta => true
  end

  def self.search_by_text(query, page = 1)
    services = []
    begin
      services = Service.search(query, :with => {:active => true},
                              :order => :average_rating, :sort_mode => :desc).compact.paginate(:page => page, :per_page => PER_PAGE)
    rescue Exception => error
      logger.error("Exception in service search for #{error.message} at #{error.backtrace.join}")
    end
    return services.compact || [].paginate(:page => page, :per_page => PER_PAGE)
  end

  def self.search_by_category_id(category_id, page = 1, query = '')
    services = []
    begin
      services = Service.search(query, :with => {:service_category_id => category_id, :active => true},
                                :order => :average_rating, :sort_mode => :desc).compact.paginate(:page => page, :per_page => PER_PAGE)
    rescue Exception => error
      logger.error("Exception in service search for #{error.message} at #{error.backtrace.join}")
    end
    return services.compact || [].paginate(:page => page, :per_page => PER_PAGE)
  end

  def to_param
    self.permalink || self.id.to_s
  end

  def activate!
    self.active = true
    self.save!
  end

  def initialize_attached_files
    self.attached_files.build
    self.attached_files.build
    self.attached_files.build
    self.attached_files.build
  end

  def after_rate
    if self.ratings_count > 0
      self.average_rating = self.rate_avg(1)
      self.save!
    end
  end
  
  protected
  def generate_permalink
    self.permalink = self.id.to_s + '-' + self.user.name + '-' + self.title
    self.permalink = self.permalink.gsub(/[^[:alnum:]]/, ' ').strip.gsub(/\W(\W)*/, '-')
    self.permalink = self.permalink[0..50].downcase
    self.save!
  end

  def send_activation_email
    if self.user && !self.user.active?
      self.user.deliver_activation_instructions!
    end
  end
  
end
