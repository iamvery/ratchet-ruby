module Ratchet
  module Data
    class Combined < Base
      include Ratchet::Data

      def initialize(data, attributes)
        @attributes = Attributes(attributes)
        super(Data(data))
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
