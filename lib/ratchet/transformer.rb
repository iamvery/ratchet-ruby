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

    def on_nut_attrs(property, attributes)
      if property
        build_dynamic_attrs(property, attributes)
      else
        build_static_attrs(attributes)
      end
    end

    private

    def build_dynamic(scope, property, tag, attributes, children)
      [
        :multi,
        [
          :block, "[#{scope}.property(#{property.inspect})].flatten.each do |#{property}|",
          build_html_tag(
            tag,
            compile(attributes),
            [
              :if, "#{property}.content?",
              [:escape, true, [:dynamic, property]],
              compile(children),
            ],
          ),
        ],
      ]
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

    def build_dynamic_attrs(property, attributes)
      [
        :multi,
        build_static_attrs(attributes),
        [:dynamic, "#{property}.build"],
      ]
    end

    def build_static_attrs(attributes)
      [:html, :attrs, build_html_attrs(attributes)]
    end

    def build_html_attrs(attributes)
      attributes.reduce([:multi]) { |attrs, (attr, value)|
        attrs << [:html, :attr, attr, [:static, value]]
      }
    end
  end
end
