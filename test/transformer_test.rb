require 'helper'
require 'ratchet/transformer'

class TransformerTest < Minitest::Test
  def test_content_transformation
    assert_transformed(
      [:nut, :tag, :data, 'title', 'div', [:multi], [:static, 'Title']],
      [
        :html, :tag, 'div',
        [:multi],
        [
          :multi,
          [:code, 'title = data["title"]'],
          [:code, 'if title.is_a?(Hash) or title.nil?'],
          [:static, 'Title'],
          [:code, 'else'],
          [:dynamic, 'title'],
          [:code, 'end'],
        ],
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
