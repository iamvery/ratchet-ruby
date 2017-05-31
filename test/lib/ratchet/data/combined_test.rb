require 'helper'
require 'ratchet/data/attributes'
require 'ratchet/data/content'
require 'ratchet/data/combined'

class CombinedDataTest < Minitest::Test
  def test_build_delegates_to_attributes
    attributes = Ratchet::Data::Attributes.new(foo: 'bar')
    data = Ratchet::Data::Combined.new(nil, attributes)
    assert_equal ' foo="bar"', data.build
  end

  def test_content_predicate_delegates_to_data
    content = Ratchet::Data::Content.new('foo')
    data = Ratchet::Data::Combined.new(content, nil)
    assert data.content?

    properties = Ratchet::Data::Properties.new(lol: 'wat')
    data = Ratchet::Data::Combined.new(properties, nil)
    refute data.content?
  end

  def test_string_representation_delegates_to_data
    content = Ratchet::Data::Content.new('foo')
    data = Ratchet::Data::Combined.new(content, nil)
    assert_equal 'foo', data.to_s
  end

  def test_property_delegates_to_data
    properties = Ratchet::Data::Properties.new(foo: 'bar')
    data = Ratchet::Data::Combined.new(properties, nil)
    assert_equal 'bar', data.property(:foo)
  end

  def test_equality
    content = Ratchet::Data::Content.new('foo')
    attributes = Ratchet::Data::Attributes.new(lol: 'wat')
    foo = Ratchet::Data::Combined.new(content, attributes)
    bar = Ratchet::Data::Combined.new(content, attributes)
    assert_equal foo, bar

    other_attributes = Ratchet::Data::Attributes.new(lol: 'no')
    baz = Ratchet::Data::Combined.new(content, other_attributes)
    refute_equal foo, baz
  end
end
