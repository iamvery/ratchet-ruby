require 'temple'

module Ratchet
  class Transformer < Temple::Filter
    def on_nut_tag(scope, property, tag, attributes, children)
      build_html_tag(
        tag,
        compile(attributes),
        property ? [:dynamic, "#{scope}[#{property.inspect}]"] : compile(children),
      )
    end

    def on_nut_attrs(attributes)
      [:html, :attrs, build_html_attrs(attributes)]
    end

    private

    def build_html_tag(name, attributes, children)
      [:html, :tag, name, attributes, children]
    end

    def build_html_attrs(attributes)
      attributes.reduce([:multi]) { |attrs, (attr, value)|
        attrs << [:html, :attr, attr, [:static, value]]
      }
    end
  end
end
