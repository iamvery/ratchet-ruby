module Ratchet
  module Data
    module None
      def self.property(*)
        self
      end

      def self.content?
        false
      end
    end
  end
end
