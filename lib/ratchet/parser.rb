require 'ox'
require 'temple'

module Ratchet
  class Parser < Temple::Parser
    PROPERTY_ATTRIBUTE = :'data-prop'

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
      property = element.attributes[PROPERTY_ATTRIBUTE]
      nut(element, property)
    end

    def nut(element, property)
      [
        :nut, :tag, property, element.value,
        [:nut, :attrs, element.attributes],
        [:multi, *element.nodes.map(&method(:parse))],
      ]
    end
  end
end
