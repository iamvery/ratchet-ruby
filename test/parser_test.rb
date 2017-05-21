require 'helper'
require 'ratchet/parser'

class ParserTest < Minitest::Test
  def test_basic_html
    assert_parsed(
      '<div>Hello</div>',
      [
        :bolt, :tag, nil, 'div',
        [:bolt, :attrs, {}],
        [:multi, [:static, 'Hello']],
      ],
    )
  end

  def test_basic_property
    assert_parsed(
      '<div data-prop="title">Hello</div>',
      [
        :bolt, :tag, 'title', 'div',
        [:bolt, :attrs, { 'data-prop': 'title' }],
        [:multi, [:static, 'Hello']],
      ],
    )
  end

  private

  def assert_parsed(source, expected)
    actual = Ratchet::Parser.new.call(source)
    assert_equal expected, actual
  end
end
