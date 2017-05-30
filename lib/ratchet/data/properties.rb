require 'ratchet/data/base'
require 'ratchet/data/none'

module Ratchet
  module Data
    class Properties < Base
      def property(name)
        data.fetch(name) { None.new }
      end
    end
  end
end
