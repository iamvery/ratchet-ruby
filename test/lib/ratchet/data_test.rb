require 'helper'
require 'ratchet/data'

class DataTest < Minitest::Test
  include Ratchet::Data

  def test_attributes_shortcuts
    attributes = Attributes(class: 'active')
    assert_equal ' class="active"', attributes.build

    attributes = A(class: 'active')
    assert_equal ' class="active"', attributes.build

    assert_equal attributes, Attributes(attributes)
  end

  def test_content_shortcuts
    content = Content('An Content')
    assert_equal 'An Content', content.to_s

    content = C('An Content')
    assert_equal 'An Content', content.to_s
  end

  def test_combined_shortcuts
    content = Combined(C('An Content'), A(foo: 'bar'))
    assert_equal 'An Content', content.to_s

    content = M(C('An Content'), A(foo: 'bar'))
    assert_equal 'An Content', content.to_s
  end

  def test_properties_shortcuts
    properties = Properties(foo: 'bar')
    assert_equal C('bar'), properties.property(:foo)

    properties = P(foo: 'bar')
    assert_equal C('bar'), properties.property(:foo)
  end

  def test_data_coersion
    raw_content = 'lolwat'
    raw_properties = { haha: raw_content }
    attributes = A(foo: 'bar')
    content = C(raw_content)
    combined = M(content, attributes)
    properties = P(raw_properties)
    none = Ratchet::Data::None.new

    assert_equal attributes, Data(attributes)
    assert_equal content, Data(content)
    assert_equal combined, Data(combined)
    assert_equal properties, Data(properties)
    assert_equal none, Data(none)
    assert_equal content, Data(raw_content)
    assert_equal [content], Data([raw_content])
    assert_equal properties, Data(raw_properties)
  end
end
