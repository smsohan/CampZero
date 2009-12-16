class User < ActiveRecord::Base
  ADMIN = 'admin'
  acts_as_authentic
  acts_as_rater
  has_many :services

  validates_presence_of :name

  def deliver_password_reset_instructions!
    reset_perishable_token!
    email = Notifier.deliver_password_reset_instructions(self)
    logger.debug email.inspect
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    email = Notifier.deliver_activation_instructions(self)
    logger.debug email.inspect
  end


  def activate!
    self.active = true
    self.save!
    UserSession.create!(self)
    self.services.each do |service|
      service.activate!
    end
    self.deliver_activation_confirmation!
  end

  def deliver_activation_confirmation!
    reset_perishable_token!
    email = Notifier.deliver_activation_confirmation(self)
    logger.debug email.inspect
  end

  def self.login_or_create user_attributes
    user = User.new user_attributes

    #if user exists auto login
    email = user.email
    existing_user = User.find_by_email email
    if existing_user
      session = UserSession.new :email => email, :password => user.password
      raise Exception.new('Invalid login credentials') unless session.save
      return user
    end
    
    #else try to save the user information
    if user.save_without_session_maintenance
      return user
    end

    raise Exception.new "Invalid user credentials #{@user.error_messages}"
    
  end
  
end
