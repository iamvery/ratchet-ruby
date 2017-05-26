require 'helper'
require 'ratchet/data/attributes'

class AttributesDataTest < Minitest::Test
  def test_build
    attributes = Ratchet::Data::Attributes.new(class: 'active')
    assert_equal attributes.build, 'class="active"'
  end

  def test_build_with_existing
    attributes = Ratchet::Data::Attributes.new(class: 'active')
    assert_equal attributes.build(id: '1'), 'id="1" class="active"'
  end

  def test_build_favors_data_over_existing
    attributes = Ratchet::Data::Attributes.new(class: 'new')
    assert_equal attributes.build(class: 'existing'), 'class="new"'
  end
end
