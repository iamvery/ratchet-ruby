require 'temple'

module Ratchet
  class Transformer < Temple::Filter
    def on_bolt_tag(property, tag, attributes)
      [
        :html, :tag, tag,
        compile(attributes),
        [:dynamic, "self[#{property.inspect}]"],
      ]
    end

    def on_bolt_attrs(attributes)
      [:html, :attrs, build_html_attrs(attributes)]
    end

    private

    def build_html_attrs(attributes)
      attributes.reduce([:multi]) { |attrs, (attr, value)|
        attrs << [:html, :attr, attr, [:static, value]]
      }
    end
  end
end
