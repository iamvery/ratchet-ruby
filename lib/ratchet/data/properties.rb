require 'ratchet/data/base'

module Ratchet
  module Data
    class Properties < Base
      def property(name)
        data.fetch(name, nil)
      end
    end
  end
end
