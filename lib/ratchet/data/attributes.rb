require 'ratchet/data/base'

module Ratchet
  module Data
    class Attributes < Base
      SEPARATOR = ' '.freeze

      def build
        SEPARATOR + build_attributes
      end

      private

      def build_attributes
        data
          .map(&method(:serialize))
          .join(SEPARATOR)
      end

      def serialize((name, value))
        safe_value = ::Temple::Utils.escape_html(value)
        %Q(#{name}="#{safe_value}")
      end
    end
  end
end
