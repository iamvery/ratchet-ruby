require 'helper'
require 'ratchet/data/attributes'

class AttributesDataTest < Minitest::Test
  def test_build
    attributes = Ratchet::Data::Attributes.new(class: 'active')
    assert_equal ' class="active"', attributes.build
  end

  def test_escaping
    attributes = Ratchet::Data::Attributes.new(href: '" class="hax" lol="')
    assert_equal ' href="&quot; class=&quot;hax&quot; lol=&quot;"', attributes.build
  end
end
