require 'temple'
require 'ratchet/html_parser'

module Ratchet
  class Engine < Temple::Engine
    use HtmlParser
    use Temple::HTML::Fast
    generator :ArrayBuffer
  end
end
