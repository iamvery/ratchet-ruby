module Ratchet
  module Data
    class Combined < Base
      def initialize(data, attributes)
        @attributes = attributes
        super(data)
      end

      def ==(other)
        super and attributes == other.attributes
      end

      def build
        attributes.build
      end

      def content?
        data.content?
      end

      def property(*args)
        data.property(*args)
      end

      def to_s
        data.to_s
      end

      protected

      attr_reader :attributes
    end
  end
end
