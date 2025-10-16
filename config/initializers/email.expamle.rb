## ActionMailer example with gmail.
require 'tls_smtp'

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  # :enable_starttls_auto => true,
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => '', # yourdomain.com
  :authentication => :plain,
  :user_name => '',  
  :password => ''
}

# ExceptionNotifier 4.x configuration
Rails.application.config.middleware.use ExceptionNotification::Rack,
  email: {
    email_prefix: "[ERROR] Inventario: ",
    sender_address: %("Exception Notifier" <exception.notifier@yourdomain.com>),
    exception_recipients: %w(recipients@yourdomain.com)
  }