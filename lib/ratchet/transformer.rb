require 'temple'

module Ratchet
  class Transformer < Temple::Filter
    def on_bolt_tag(property, tag, attributes, children)
      [
        :html, :tag, tag,
        compile(attributes),
        property ? [:dynamic, "self[#{property.inspect}]"] : compile(children),
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
