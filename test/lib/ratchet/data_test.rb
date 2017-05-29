require 'helper'
require 'ratchet/data'

class DataTest < Minitest::Test
  include Ratchet::Data

  def test_attributes_shortcuts
    attributes = Attributes(class: 'active')
    assert_equal ' class="active"', attributes.build

    attributes = A(class: 'active')
    assert_equal ' class="active"', attributes.build
  end

  def test_content_shortcuts
    content = Content('An Content')
    assert_equal 'An Content', content.to_s

    content = C('An Content')
    assert_equal 'An Content', content.to_s
  end

  def test_properties_shortcuts
    properties = Properties(foo: 'bar')
    assert_equal 'bar', properties.property(:foo)

    properties = P(foo: 'bar')
    assert_equal 'bar', properties.property(:foo)
  end
end
