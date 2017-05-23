require 'temple'

module Ratchet
  class Transformer < Temple::Filter
    def on_nut_tag(scope, property, tag, attributes, children)
      if property
        build_dynamic(scope, property, tag, attributes, children)
      else
        build_static(scope, property, tag, attributes, children)
      end
    end

    def on_nut_attrs(attributes)
      [:html, :attrs, build_html_attrs(attributes)]
    end

    private

    def build_dynamic(scope, property, tag, attributes, children)
      build_html_tag(
        tag,
        compile(attributes),
        [
          :multi,
          [:code, "#{property} = #{scope}[#{property.inspect}]"],
          [:code, "if #{property}.is_a?(Hash) or #{property}.nil?"],
          compile(children),
          [:code, 'else'],
          [:dynamic, property],
          [:code, 'end'],
        ],
      )
    end

    def build_static(scope, property, tag, attributes, children)
      build_html_tag(
        tag,
        compile(attributes),
        compile(children),
      )
    end

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
