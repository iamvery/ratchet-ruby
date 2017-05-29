require 'ratchet/data/base'

module Ratchet
  module Data
    class Attributes < Base
      SEPARATOR = ' '.freeze

      def build
        build_attributes
      end

      private

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
