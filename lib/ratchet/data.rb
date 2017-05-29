require 'ratchet/data/content'
require 'ratchet/data/properties'

module Ratchet
  module Data
    def Content(data)
      Content.new(data)
    end
    module_function :Content
    alias_method :C, :Content

    def Properties(data)
      Properties.new(data)
    end
    module_function :Properties
    alias_method :P, :Properties
  end
end
