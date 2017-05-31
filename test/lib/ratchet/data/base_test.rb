require 'helper'
require 'ratchet/data/base'

class BaseDataTest < Minitest::Test
  def test_equality
    foo = Ratchet::Data::Base.new('foo')
    bar = Ratchet::Data::Base.new('foo')
    assert_equal foo, bar

    baz = Ratchet::Data::Base.new('baz')
    refute_equal foo, baz
  end
end
