require 'ox'

module Ratchet
  class Parser
    def call(source)
      document = Ox.parse(source)
      parse(document)
    end

    private

    def parse(element)
      if element.is_a?(Ox::Element)
        parse_element(element)
      else
        [:static, element]
      end
    end

    def parse_element(element)
      html(element)
    end

    def html(element)
      [
        :html, :tag, element.value,
        [:multi],
        [:multi, *element.nodes.map(&method(:parse))],
      ]
    end
  end
end
