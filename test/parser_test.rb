require 'helper'
require 'ratchet/parser'

class ParserTest < Minitest::Test
  def test_basic_html
    assert_parsed(
      '<div>Hello</div>',
      [:html, :tag, 'div', [:multi], [:multi, [:static, 'Hello']]],
    )
  end

  private

  def assert_parsed(source, expected)
    actual = Ratchet::Parser.new.call(source)
    assert_equal expected, actual
  end
end
