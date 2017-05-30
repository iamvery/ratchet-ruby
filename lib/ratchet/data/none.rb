require 'ratchet/data/base'

module Ratchet
  module Data
    class None < Base
      def initialize
        super(nil)
      end

      def property(*)
        self
      end
    end
  end
end
