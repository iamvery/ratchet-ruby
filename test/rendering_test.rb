require 'helper'
require 'ratchet/data'
require 'ratchet/data/none'
require 'ratchet/templates/tilt'

class RenderingTest < Minitest::Test
  include Ratchet::Data

  Context = Struct.new(:data)

  def render(source, data = Ratchet::Data::None.new)
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
    output = render(source, P(title: T('Ratchet')))
    assert_equal '<div data-prop="title">Ratchet</div>', output
  end

  def test_coerces_raw_data_into_content
    source = '<div data-prop="title">An Title</div>'
    output = render(source, P(title: 'Ratchet'))
    assert_equal '<div data-prop="title">Ratchet</div>', output
  end

  def test_coerces_raw_data_into_properties
    source = '<div data-prop="title">An Title</div>'
    output = render(source, title: 'Ratchet')
    assert_equal '<div data-prop="title">Ratchet</div>', output
  end

  def test_coerces_raw_data_into_combined
    source = '<div data-prop="title">An Title</div>'
    output = render(source, title: M('Ratchet', class: 'active'))
    assert_equal '<div data-prop="title" class="active">Ratchet</div>', output
  end

  def test_renders_tag_attributes
    source = '<a data-prop="link">Click me!</a>'
    output = render(source, P(link: A(href: '/')))
    assert_equal '<a data-prop="link" href="/">Click me!</a>', output
  end

  def test_renders_combined_attributes_and_content
    source = '<a data-prop="link">An Link</a>'
    output = render(source, P(link: M(T('Click me!'), A(href: '/'))))
    assert_equal '<a data-prop="link" href="/">Click me!</a>', output
  end

  def test_combined_data_with_nested_properties
    source = '<div data-prop="post"><span data-prop="title"><span></div>'
    output = render(source, P(post: M(P(title: T('lolwat')), A(class: 'fancy'))))
    assert_equal '<div data-prop="post" class="fancy"><span data-prop="title">lolwat</span></div>', output
  end

  def test_preserves_tag_content
    source = '<div data-prop="title">An Title</div>'
    output = render(source)
    assert_equal source, output
  end

  def test_nested_properties
    source = '<div data-prop="post"><span data-prop="title">An Title</span></div>'
    output = render(source, P(post: P(title: T('Ratchet'))))
    assert_equal '<div data-prop="post"><span data-prop="title">Ratchet</span></div>', output
  end

  def test_iteration
    source = '<div data-prop="items">An Item</div>'
    output = render(source, P(items: [T('first'), T('second')]))
    assert_equal '<div data-prop="items">first</div><div data-prop="items">second</div>', output
  end

  def test_escaping
    source = '<div data-prop="foo"></div>'
    output = render(source, P(foo: T('<span>hacked!</span>')))
    assert_equal '<div data-prop="foo">&lt;span&gt;hacked!&lt;/span&gt;</div>', output

    source = '<a data-prop="link"></a>'
    output = render(source, P(link: A(href: '" class="hacked" lol="')))
    assert_equal '<a data-prop="link" href="&quot; class=&quot;hacked&quot; lol=&quot;"></a>', output
  end

  def test_comment
    source = '<div><!--comment--></div>'
    output = render(source)
    assert_equal source, output
  end
end
