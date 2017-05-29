require 'ratchet/data/base'

module Ratchet
  module Data
    class Content < Base
      def content?
        true
      end

      def to_s
        data.to_s
      end
    end
  end
end
