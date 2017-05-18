require 'temple'
require 'ratchet/engine'

module Ratchet
  Template = Temple::Templates::Tilt(Engine)
end
