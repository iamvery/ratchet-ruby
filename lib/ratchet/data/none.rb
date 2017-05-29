module Ratchet
  module Data
    module None
      def self.property(*)
        self
      end

      # Noop for attributes
      def self.build
      end

      def self.content?
        false
      end
    end
  end
end
