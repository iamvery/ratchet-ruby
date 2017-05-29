require 'helper'
require 'ratchet/parser'

class ParserTest < Minitest::Test
  def test_basic_html
    assert_parsed(
      '<div>Hello</div>',
      [:multi, [
        :nut, :tag, :data, nil, 'div',
        [:nut, :attrs, nil, {}],
        [:multi, [:static, 'Hello']],
      ]],
    )
  end

  def test_comment
    assert_parsed(
      '<div><!-- comment --></div>',
      [:multi, [
        :nut, :tag, :data, nil, 'div',
        [:nut, :attrs, nil, {}],
        [:multi, [:html, :comment, [:static, 'comment']]],
      ]],
    )
  end

  def test_fragment
    assert_parsed(
      '<div>first</div><div>second</div>',
      [
        :multi,
        [:nut, :tag, :data, nil, 'div', [:nut, :attrs, nil, {}], [:multi, [:static, 'first']]],
        [:nut, :tag, :data, nil, 'div', [:nut, :attrs, nil, {}], [:multi, [:static, 'second']]],
      ],
    )
  end

  def test_self_closing
    assert_parsed(
      '<div><img></div>',
      [:multi, [
        :nut, :tag, :data, nil, 'div',
        [:nut, :attrs, nil, {}],
        [
          :multi,
          [:nut, :tag, :data, nil, 'img', [:nut, :attrs, nil, {}], [:multi]],
        ],
      ]],
    )
  end

  def test_basic_property
    assert_parsed(
      '<div data-prop="title">Hello</div>',
      [:multi, [
        :nut, :tag, :data, 'title', 'div',
        [:nut, :attrs, 'title', { 'data-prop' => 'title' }],
        [:multi, [:static, 'Hello']],
      ]],
    )
  end

  def test_nested_property
    assert_parsed(
      '<div data-prop="post"><span data-prop="title"></span></div>',
      [:multi, [
        :nut, :tag, :data, 'post', 'div',
        [:nut, :attrs, 'post', { 'data-prop' => 'post' }],
        [
          :multi,
          [
            :nut, :tag, 'post', 'title', 'span',
            [:nut, :attrs, 'title', { 'data-prop' => 'title' }],
            [:multi],
          ],
        ],
      ]],
    )
  end

  def test_mixed_properties
    assert_parsed(
      <<-HTML,
        <ul>
          <li data-prop="post">
            <div><span data-prop="title"></span></div>
          </li>
        </ul>
      HTML
      [:multi, [
        :nut, :tag, :data, nil, 'ul',
        [:nut, :attrs, nil, {}],
        [
          :multi,
          [
            :nut, :tag, :data, 'post', 'li',
            [:nut, :attrs, 'post', { 'data-prop' => 'post' }],
            [
              :multi,
              [
                :nut, :tag, 'post', nil, 'div',
                [:nut, :attrs, nil, {}],
                [
                  :multi,
                  [
                    :nut, :tag, 'post', 'title', 'span',
                    [:nut, :attrs, 'title', { 'data-prop' => 'title' }],
                    [:multi],
                  ],
                ]
              ],
            ],
          ],
        ],
      ]],
    )
  end

  private

  def assert_parsed(source, expected)
    actual = Ratchet::Parser.new.call(source)
    assert_equal expected, actual
  end
end
