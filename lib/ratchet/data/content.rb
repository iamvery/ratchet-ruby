require 'ratchet/data/base'

module Ratchet
  module Data
    class Content < Base
      def to_s
        data.to_s
      end
    end
  end
end
