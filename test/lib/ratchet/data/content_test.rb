require 'helper'
require 'ratchet/data/content'

class DataContentTest < Minitest::Test
  def test_string_representation_is_its_data
    content = Ratchet::Data::Content.new('foo')
    assert_equal 'foo', content.to_s
  end
end
