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

ExceptionNotifier.exception_recipients = %w(recipients@yourdomain.com)
ExceptionNotifier.sender_address = %("Exception Notifier" <exception.notifier@yourdomain.com>)
ExceptionNotifier.email_prefix ="[ERROR] Inventario: "