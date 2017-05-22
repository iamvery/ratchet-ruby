require 'helper'
require 'ratchet/transformer'

class TransformerTest < Minitest::Test
  def test_content_transformation
    assert_transformed(
      [:nut, :tag, :data, 'title', 'div', [:multi], [:multi]],
      [
        :html, :tag, 'div',
        [:multi],
        [:dynamic, 'data["title"]'],
      ],
    )
  end

  def test_attribute_preservation
    assert_transformed(
      [:nut, :tag, :data, nil, 'div', [:nut, :attrs, { foo: 'bar' }], [:multi]],
      [
        :html, :tag, 'div',
        [:html, :attrs, [:multi, [:html, :attr, :foo, [:static, 'bar']]]],
        [:multi],
      ],
    )
  end

  private

  def assert_transformed(source, expected)
    actual = Ratchet::Transformer.new.call(source)
    assert_equal expected, actual
  end
end
