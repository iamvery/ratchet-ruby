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

  def test_omit_missing
    assert_transformed(
      [:nut, :tag, :data, 'title', 'div', [:multi], [:static, 'Title']],
      [
        :multi,
        [
          :block, '[data.property("title")].flatten.each do |title|',
          [
            :if, 'title.is_a?(Ratchet::Data::None)',
            [:static, ''],
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
      ],
      omit_missing: true,
    )
  end

  def test_attribute_preservation
    assert_transformed(
      [:nut, :attrs, nil, { foo: 'bar' }],
      [:html, :attrs, [:multi, [:html, :attr, :foo, [:static, 'bar']]]],
    )
  end

  def test_attributes_transformation
    assert_transformed(
      [:nut, :attrs, 'title', { foo: 'bar' }],
      [
        :multi,
        [:html, :attrs, [:multi, [:html, :attr, :foo, [:static, 'bar']]]],
        [:dynamic, 'title.build'],
      ],
    )
  end

  private

  def assert_transformed(source, expected, omit_missing: false)
    actual = Ratchet::Transformer.new(omit_missing: omit_missing).call(source)
    assert_equal expected, actual
  end
end
