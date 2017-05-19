require 'helper'
require 'ratchet/transformer'

class TransformerTest < Minitest::Test
  def test_content_transformation
    assert_transformed(
      [:bolt, 'title', 'div'],
      [
        :html, :tag, 'div',
        [:multi],
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
