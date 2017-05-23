require 'ox'
require 'temple'

module Ratchet
  class Parser < Temple::Parser
    DEFAULT_SCOPE = :data
    PROPERTY_ATTRIBUTE = :'data-prop'

    def call(source)
      document = Ox.parse(source)
      parse(document)
    end

    private

    def parse(element, scope = DEFAULT_SCOPE)
      if element.is_a?(Ox::Element)
        parse_element(element, scope)
      elsif element.is_a?(Ox::Comment)
        [:html, :comment, [:static, element.value]]
      else
        [:static, element]
      end
    end

    def parse_element(element, scope)
      property = element.attributes[PROPERTY_ATTRIBUTE]
      nut(element, scope, property)
    end

    def nut(element, scope, property)
      new_scope = property ? property : scope
      [
        :nut, :tag, scope, property, element.value,
        [:nut, :attrs, element.attributes],
        [:multi, *element.nodes.map { |e| parse(e, new_scope) }],
      ]
    end
  end
end
