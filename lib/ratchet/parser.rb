require 'ox'
require 'temple'

Ox.default_options = {
  mode: :generic,
  effort: :tolerant,
  smart: true,
}

module Ratchet
  class Parser < Temple::Parser
    DATA_INPUT_NAME = :data
    DEFAULT_SCOPE = :_data
    PROPERTY_ATTRIBUTE = 'data-prop'.freeze

    def call(source)
      source = "<wrapper>#{source}</wrapper>"
      document = Ox.parse(source)
      [
        :multi,
        [:code, "#{DEFAULT_SCOPE} = Ratchet::Data.Data(#{DATA_INPUT_NAME})"],
        *document.nodes.map(&method(:parse)),
      ]
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
      property = element.attributes[PROPERTY_ATTRIBUTE]&.to_sym
      nut(element, scope, property)
    end

    def nut(element, scope, property)
      new_scope = property ? property : scope
      [
        :nut, :tag, scope, property, element.value,
        [:nut, :attrs, property, element.attributes],
        [:multi, *element.nodes.map { |e| parse(e, new_scope) }],
      ]
    end
  end
end
