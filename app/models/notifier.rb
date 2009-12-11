class Notifier < ActionMailer::Base
  

  def password_reset_instructions(user, sent_at = Time.now)
    subject    'Complete the CampZero.com signup process'
    recipients user.email
    from       'CampZero.com'
    sent_on    sent_at

    body       :password_reset_url => edit_password_reset_url({:id => user.perishable_token})
  end

  def activation_instructions(user, sent_at = Time.now)
    subject    'Complete the CampZero.com signup process'
    recipients user.email
    from       'CampZero.com'
    sent_on    sent_at

    body       :activation_url => new_activation_url({:id => user.perishable_token})
  end

  def activation_confirmation(user, sent_at = Time.now)
    subject    'Completed your CampZero.com signup'
    recipients user.email
    from       'CampZero.com'
    sent_on    sent_at
  end

end
