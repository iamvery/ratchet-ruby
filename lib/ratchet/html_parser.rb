require 'ox'

module Ratchet
  class HtmlParser
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
        [:html, :attrs, [:multi]],
        [:multi],
      ]
    end
  end
end
