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
