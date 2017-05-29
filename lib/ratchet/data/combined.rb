module Ratchet
  module Data
    class Combined < Base
      def initialize(data, attributes)
        @attributes = attributes
        super(data)
      end

      def build
        attributes.build
      end

      def content?
        data.content?
      end

      def to_s
        data.to_s
      end

      private

      attr_reader :attributes
    end
  end
end
