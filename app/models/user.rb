class User < ActiveRecord::Base
  acts_as_authentic
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
    self.deliver_activation_confirmation!
  end

  def deliver_activation_confirmation!
    reset_perishable_token!
    email = Notifier.deliver_activation_confirmation(self)
    logger.debug email.inspect
  end
  
end
