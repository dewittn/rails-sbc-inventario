ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup'

# Fix for Ruby 2.7+ compatibility with Rails 4.2
# BigDecimal.new was removed in Ruby 2.7, but Rails 4.2 expects it
if RUBY_VERSION >= '2.7'
  require 'bigdecimal'

  class BigDecimal
    def self.new(*args, **kwargs)
      BigDecimal(*args, **kwargs)
    end
  end
end

# Fix for Tilt::ErubisTemplate missing in newer Tilt versions
# HAML 5.x still references it, but Tilt dropped Erubis support
require 'tilt'
unless defined?(Tilt::ErubisTemplate)
  module Tilt
    class ErubisTemplate < ERBTemplate
    end
  end
end
