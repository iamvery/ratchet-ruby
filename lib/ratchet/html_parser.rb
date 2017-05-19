require 'ox'
require 'temple'

module Ratchet
  class HtmlParser < Temple::Parser
    def call(html)
      document = Ox.parse(html)
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
      [
        :html,
        :tag,
        element.value,
        [:html, :attrs, parse_attributes(element.attributes)],
        [:multi, *element.nodes.map(&method(:parse))],
      ]
    end

    def parse_attributes(attributes)
      attributes.reduce([:multi]) { |attrs, (name, value)|
        attrs << [:html, :attr, name, [:static, value]]
      }
    end
  end
end
