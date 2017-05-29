require 'helper'
require 'ratchet/data/attributes'

class AttributesDataTest < Minitest::Test
  def test_build
    attributes = Ratchet::Data::Attributes.new(class: 'active')
    assert_equal ' class="active"', attributes.build
  end
end
