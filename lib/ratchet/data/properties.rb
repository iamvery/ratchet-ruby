require 'ratchet/data/base'
require 'ratchet/data/none'

module Ratchet
  module Data
    class Properties < Base
      include Data

      def property(name)
        Data(data.fetch(name) { None.new })
      end
    end
  end
end
