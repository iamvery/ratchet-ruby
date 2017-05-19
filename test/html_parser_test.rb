require 'helper'
require 'ratchet/html_parser'

class HtmlParserTest < Minitest::Test
  def test_basic_html_parsing
    assert_parsed(
      '<div>Hello, World.</div>',
      [
        :html, :tag, 'div',
        [
          :html, :attrs,
          [:multi],
        ],
        [
          :multi,
          [:static, 'Hello, World.']
        ]
      ],
    )
  end

  private

  def assert_parsed(html, expected)
    actual = Ratchet::HtmlParser.new.call(html)
    assert_equal expected, actual
  end
end
