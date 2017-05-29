module Ratchet
  module Data
    class Base
      def initialize(data)
        @data = data
      end

      # Override in child classes
      def build
      end

      # Override in child classes
      def content?
        false
      end

      private

      attr_reader :data
    end
  end
end
