module Ratchet
  module Data
    class Base
      def initialize(data)
        @data = data
      end

      def ==(other)
        data == other.data
      end

      # Override in child classes
      def build
      end

      # Override in child classes
      def content?
        false
      end

      protected

      attr_reader :data
    end
  end
end
