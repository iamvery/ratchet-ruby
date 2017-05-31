require 'helper'
require 'ratchet/data/properties'
require 'ratchet/data/none'

class PropertiesDataTest < Minitest::Test
  def test_property
    content = Ratchet::Data::Content.new('wat')
    properties = Ratchet::Data::Properties.new('lol' => content)
    assert_equal content, properties.property('lol')

    properties = Ratchet::Data::Properties.new(lol: 'wat')
    assert_kind_of Ratchet::Data::None, properties.property(:not_found)
  end

  def test_raw_data_is_coerced
    properties = Ratchet::Data::Properties.new(lol: 'wat')
    assert_equal Ratchet::Data::Content.new('wat'), properties.property(:lol)
  end
end
