require 'ratchet/data/attributes'
require 'ratchet/data/content'
require 'ratchet/data/combined'
require 'ratchet/data/properties'

module Ratchet
  module Data
    def Attributes(data)
      Attributes.new(data)
    end
    module_function :Attributes
    alias_method :A, :Attributes

    def Content(data)
      Content.new(data)
    end
    module_function :Content
    alias_method :C, :Content

    def Combined(*args)
      Combined.new(*args)
    end
    module_function :Combined
    alias_method :M, :Combined

    def Properties(data)
      Properties.new(data)
    end
    module_function :Properties
    alias_method :P, :Properties
  end
end
