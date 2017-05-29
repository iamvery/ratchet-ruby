require 'ratchet/data/base'

module Ratchet
  module Data
    class Attributes < Base
      SEPARATOR = ' '.freeze

      def build
        if block_given?
          [yield, attributes].join(SEPARATOR)
        else
          attributes
        end
      end

      private

      def attributes
        @attributes ||= build_attributes
      end

      def build_attributes
        data
          .map(&method(:serialize))
          .join(SEPARATOR)
      end

      def serialize((name, value))
        %Q(#{name}="#{value}")
      end
    end
  end
end
