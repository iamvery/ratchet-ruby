require 'temple'
require 'ratchet/parser'
require 'ratchet/transformer'

module Ratchet
  class Engine < Temple::Engine
    use Parser
    use Transformer
    use Temple::HTML::Fast
    generator :ArrayBuffer
  end
end
