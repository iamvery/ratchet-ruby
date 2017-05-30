require 'helper'
require 'ratchet/data/properties'
require 'ratchet/data/none'

class PropertiesDataTest < Minitest::Test
  def test_property
    properties = Ratchet::Data::Properties.new('lol' => 'wat')
    assert_equal 'wat', properties.property('lol')

    properties = Ratchet::Data::Properties.new(lol: 'wat')
    assert_kind_of Ratchet::Data::None, properties.property(:not_found)
  end
end
