# Load CotoSolutions vendor plugin and lib files
# Rails 4.2 doesn't auto-load vendor/plugins or lib/ like Rails 2.3 did

# Load the helper first
require Rails.root.join('vendor', 'plugins', 'coto_solutions', 'app', 'helpers', 'coto_helper.rb')

# Then load the main plugin file
require Rails.root.join('vendor', 'plugins', 'coto_solutions', 'lib', 'coto_solutions.rb')

# Load restful_authentication plugin modules
require Rails.root.join('vendor', 'plugins', 'restful_authentication', 'lib', 'authentication.rb')
require Rails.root.join('vendor', 'plugins', 'restful_authentication', 'lib', 'authentication', 'by_password.rb')
require Rails.root.join('vendor', 'plugins', 'restful_authentication', 'lib', 'authentication', 'by_cookie_token.rb')

# Load AuthenticatedSystem from lib/
require Rails.root.join('lib', 'authenticated_system.rb')
