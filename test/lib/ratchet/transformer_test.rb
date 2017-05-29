require 'helper'
require 'ratchet/transformer'

class TransformerTest < Minitest::Test
  def test_content_transformation
    assert_transformed(
      [:nut, :tag, :data, 'title', 'div', [:multi], [:static, 'Title']],
      [
        :multi,
        [
          :block, '[data.property("title")].flatten.each do |title|',
          [
            :html, :tag, 'div',
            [:multi],
            [
              :if, 'title.content?',
              [:escape, true, [:dynamic, 'title']],
              [:static, 'Title'],
            ],
          ],
        ],
      ],
    )
  end

  def test_attribute_preservation
    assert_transformed(
      [:nut, :attrs, nil, { foo: 'bar' }],
      [:html, :attrs, [:multi, [:html, :attr, :foo, [:static, 'bar']]]],
    )
  end

  private

  def assert_transformed(source, expected)
    actual = Ratchet::Transformer.new.call(source)
    assert_equal expected, actual
  end
end
