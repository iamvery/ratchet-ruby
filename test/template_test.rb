require 'helper'
require 'ratchet/template'

class TemplateTest < Minitest::Test
  def render(source, context = nil)
    Ratchet::Template.new { source }.render(context)
  end

  def test_renders_basic_html
    source = '<div>Hello, World.</div>'
    output = render(source)
    assert_equal source, output
  end
end
