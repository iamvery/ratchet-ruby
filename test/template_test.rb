require 'helper'
require 'ratchet/templates/tilt'

class TemplateTest < Minitest::Test
  Context = Struct.new(:data)

  def render(source, data = nil)
    context = Context.new(data)
    Ratchet::Templates::Tilt.new { source }.render(context)
  end

  def test_renders_basic_html
    source = '<div class="greet">Hello, World.</div>'
    output = render(source)
    assert_equal source, output
  end

  def test_replaces_tag_content
    source = '<div data-prop="title">An Title</div>'
    output = render(source, 'title' => 'Ratchet')
    assert_equal '<div data-prop="title">Ratchet</div>', output
  end

  def test_nested_properties
    source = '<div data-prop="post"><span data-prop="title">An Title</span></div>'
    output = render(source, 'post' => { 'title' => 'Ratchet' })
    assert_equal '<div data-prop="post"><span data-prop="title">Ratchet</span></div>', output
  end
end
