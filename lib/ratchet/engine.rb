require 'temple'
require 'ratchet/parser'
require 'ratchet/transformer'

module Ratchet
  class Engine < Temple::Engine
    define_options(generator: Temple::Generators::ArrayBuffer)

    use Parser
    use Transformer
    use Temple::HTML::Fast
    use(:Generator) { options[:generator] }
  end
end
