require 'temple'
require 'ratchet/parser'
require 'ratchet/transformer'

module Ratchet
  class Engine < Temple::Engine
    define_options(generator: Temple::Generators::ArrayBuffer)

    use Parser
    use Transformer
    use Temple::HTML::Fast
    use Temple::Filters::ControlFlow
    use Temple::Filters::Escapable
    use Temple::Filters::MultiFlattener
    use Temple::Filters::StaticMerger
    use(:generator) { options[:generator] }
  end
end
