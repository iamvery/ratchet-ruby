require 'temple'

module Ratchet
  class NaiveParser < Temple::Parser
    def call(string)
      [:static, string]
    end
  end

  class Engine < Temple::Engine
    use NaiveParser
    generator :ArrayBuffer
  end
end
