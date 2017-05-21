require 'helper'
require 'ratchet/transformer'

class TransformerTest < Minitest::Test
  def test_content_transformation
    assert_transformed(
      [:bolt, :tag, 'title', 'div', [:multi], [:multi]],
      [
        :html, :tag, 'div',
        [:multi],
        [:dynamic, 'self["title"]'],
      ],
    )
  end

  def test_attribute_preservation
    assert_transformed(
      [:bolt, :tag, 'title', 'div', [:bolt, :attrs, { foo: 'bar' }], [:multi]],
      [
        :html, :tag, 'div',
        [:html, :attrs, [:multi, [:html, :attr, :foo, [:static, 'bar']]]],
        [:dynamic, 'self["title"]'],
      ],
    )
  end

  private

  def assert_transformed(source, expected)
    actual = Ratchet::Transformer.new.call(source)
    assert_equal expected, actual
  end
end
