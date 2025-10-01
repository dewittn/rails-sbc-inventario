require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module SbcInventario
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.active_record.raise_in_transactional_callbacks = true

    # Load sweepers from app/sweepers (will need to refactor these later)
    config.autoload_paths += %W(#{config.root}/app/sweepers)

    # Session configuration
    config.session_store :cookie_store, key: '_inventario2.0_session'
    config.secret_key_base = '***REMOVED***'
  end
end
