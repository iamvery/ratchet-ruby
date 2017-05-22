require 'temple'
require 'ratchet/engine'

module Ratchet
  module Templates
    Rails = Temple::Templates::Rails(
      Engine,
      register_as: :bolt,
      generator: Temple::Generators::RailsOutputBuffer,
    )
  end
end
