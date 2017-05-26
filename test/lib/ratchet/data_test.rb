require 'helper'
require 'ratchet/data'

class DataTest < Minitest::Test
  include Ratchet::Data

  def test_properties_shortcuts
    properties = Properties(foo: 'bar')
    assert_equal 'bar', properties.property(:foo)

    properties = P(foo: 'bar')
    assert_equal 'bar', properties.property(:foo)
  end
end
