module Ratchet
  module Data
    class Properties
      def initialize(data)
        @data = data
      end

      def property(name)
        data.fetch(name)
      end

      private

      attr_reader :data
    end
  end
end
