require 'ratchet/data/base'

module Ratchet
  module Data
    class Attributes < Base
      SEPARATOR = ' '.freeze

      def build
        data
          .map(&method(:serialize))
          .join(SEPARATOR)
      end

      private

      def serialize((name, value))
        %Q(#{name}="#{value}")
      end
    end
  end
end
