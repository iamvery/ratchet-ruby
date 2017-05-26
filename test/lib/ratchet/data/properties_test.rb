require 'helper'
require 'ratchet/data/properties'

class PropertiesDataTest < Minitest::Test
  def test_property
    properties = Ratchet::Data::Properties.new('lol' => 'wat')
    assert_equal 'wat', properties.property('lol')
  end
end
