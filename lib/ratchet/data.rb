require 'ratchet/data/properties'

module Ratchet
  module Data
    def Properties(data)
      Properties.new(data)
    end
    module_function :Properties
    alias_method :P, :Properties
  end
end
