module Ratchet
  module Data
    class Base
      def initialize(data)
        @data = data
      end

      private

      attr_reader :data
    end
  end
end
