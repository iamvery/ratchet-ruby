require 'temple'
require 'ratchet/engine'

module Ratchet
  Template = Temple::Templates::Tilt(Engine)

  if defined?(::ActionView)
    RailsTemplate = Temple::Templates::Rails(
      Engine,
      generator: Temple::Generators::RailsOutputBuffer,
    )
  end
end
