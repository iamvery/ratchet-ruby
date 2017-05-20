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

  def test_replaces_tag_content
    source = '<div data-prop="title">An Title</div>'
    output = render(source, 'title' => 'Ratchet')
    assert_equal '<div data-prop="title">Ratchet</div>', output
  end
end
