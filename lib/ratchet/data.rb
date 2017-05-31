require 'ratchet/data/attributes'
require 'ratchet/data/content'
require 'ratchet/data/combined'
require 'ratchet/data/properties'

module Ratchet
  module Data
    # TODO consider explicit conversion protocols rather than type checks for
    # fall-throughs, e.g. to_attrs, to_ratchet_data, etc.

    def Attributes(data)
      return data if data.is_a?(Attributes)
      Attributes.new(data)
    end
    module_function :Attributes
    alias_method :A, :Attributes

    def Content(data)
      Content.new(data)
    end
    module_function :Content
    alias_method :T, :Content

    def Combined(*args)
      Combined.new(*args)
    end
    module_function :Combined
    alias_method :C, :Combined

    def Properties(data)
      Properties.new(data)
    end
    module_function :Properties
    alias_method :P, :Properties

    def Data(data)
      # TODO consider using array and hash conversion protocols to loosen
      # coupling on the exact type. This would allow folks to use any
      # convertible type when structuring data.
      case data
      when Base then data
      when Array then data.map(&method(:Data))
      when Hash then Properties(data)
      else Content(data)
      end
    end
    module_function :Data
  end
end
