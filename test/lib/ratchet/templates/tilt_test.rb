require 'helper'
require 'ratchet/data'
require 'ratchet/templates/tilt'

class TemplateTest < Minitest::Test
  include Ratchet::Data

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

  def test_renders_self_closing_tag
    source = '<div><img></div>'
    output = render(source)
    assert_equal '<div><img /></div>', output
  end

  def test_renders_fragment
    source = '<div>first</div><div>second</div>'
    output = render(source)
    assert_equal source, output
  end

  def test_replaces_tag_content
    source = '<div data-prop="title">An Title</div>'
    output = render(source, P('title' => C('Ratchet')))
    assert_equal '<div data-prop="title">Ratchet</div>', output
  end

  def test_nested_properties
    source = '<div data-prop="post"><span data-prop="title">An Title</span></div>'
    output = render(source, P('post' => P('title' => C('Ratchet'))))
    assert_equal '<div data-prop="post"><span data-prop="title">Ratchet</span></div>', output
  end

  def test_iteration
    source = '<div data-prop="items">An Item</div>'
    output = render(source, P('items' => [C('first'), C('second')]))
    assert_equal '<div data-prop="items">first</div><div data-prop="items">second</div>', output
  end

  def test_escaping
    source = '<div data-prop="foo"></div>'
    output = render(source, P('foo' => C('<span>hacked!</span>')))
    assert_equal '<div data-prop="foo">&lt;span&gt;hacked!&lt;/span&gt;</div>', output
  end

  def test_comment
    source = '<div><!--comment--></div>'
    output = render(source)
    assert_equal source, output
  end
end
