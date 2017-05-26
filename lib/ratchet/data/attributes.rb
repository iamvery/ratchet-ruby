require 'ratchet/data/base'

module Ratchet
  module Data
    class Attributes < Base
      SEPARATOR = ' '.freeze

      def build(existing = Hash.new)
        existing.merge(data)
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
