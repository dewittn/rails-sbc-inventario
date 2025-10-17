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

    # Load lib files (Rails 4.2 doesn't auto-load lib/ by default)
    config.autoload_paths += %W(#{config.root}/lib)

    # Load vendor plugin files
    config.autoload_paths += %W(#{config.root}/vendor/plugins/coto_solutions/lib)
    config.autoload_paths += %W(#{config.root}/vendor/plugins/coto_solutions/app/helpers)

    # Session configuration
    config.session_store :cookie_store, key: '_inventario2.0_session'
    config.secret_key_base = 'a48925b3938f307c5b01e60870a87571c30aa86beedf2540fe2c532ee7db3a251393026253713573dee0573cc6002d8db5d505598c8b434d360385344022c052'
  end
end
