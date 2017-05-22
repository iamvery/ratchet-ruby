require 'helper'
require 'ratchet/parser'

class ParserTest < Minitest::Test
  def test_basic_html
    assert_parsed(
      '<div>Hello</div>',
      [
        :nut, :tag, :data, nil, 'div',
        [:nut, :attrs, {}],
        [:multi, [:static, 'Hello']],
      ],
    )
  end

  def test_basic_property
    assert_parsed(
      '<div data-prop="title">Hello</div>',
      [
        :nut, :tag, :data, 'title', 'div',
        [:nut, :attrs, { 'data-prop': 'title' }],
        [:multi, [:static, 'Hello']],
      ],
    )
  end

  def test_nested_property
    assert_parsed(
      '<div data-prop="post"><span data-prop="title"></span></div>',
      [
        :nut, :tag, :data, 'post', 'div',
        [:nut, :attrs, { 'data-prop': 'post' }],
        [
          :multi,
          [
            :nut, :tag, 'post', 'title', 'span',
            [:nut, :attrs, { 'data-prop': 'title' }],
            [:multi],
          ],
        ],
      ],
    )
  end

  private

  def assert_parsed(source, expected)
    actual = Ratchet::Parser.new.call(source)
    assert_equal expected, actual
  end
end
