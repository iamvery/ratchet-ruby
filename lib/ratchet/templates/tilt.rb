require 'temple'
require 'ratchet/engine'

module Ratchet
  module Templates
    Tilt = Temple::Templates::Tilt(Engine)
  end
end
