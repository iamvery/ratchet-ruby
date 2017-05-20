require 'temple'

module Ratchet
  class Transformer < Temple::Filter
    def on_bolt_tag(property, tag)
      [
        :html, :tag, tag,
        [:multi],
        [:dynamic, "self[#{property.inspect}]"],
      ]
    end
  end
end
