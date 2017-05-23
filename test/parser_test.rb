require 'helper'
require 'ratchet/parser'

class ParserTest < Minitest::Test
  def test_basic_html
    assert_parsed(
      '<div>Hello</div>',
      [
        :nut, :tag, :data, nil, 'div',
        [:nut, :attrs, {}],
        [:multi, [:static, 'Hello']],
      ],
    )
  end

  def test_comment
    assert_parsed(
      '<div><!-- comment --></div>',
      [
        :nut, :tag, :data, nil, 'div',
        [:nut, :attrs, {}],
        [:multi, [:html, :comment, [:static, 'comment']]],
      ],
    )
  end

  def test_basic_property
    assert_parsed(
      '<div data-prop="title">Hello</div>',
      [
        :nut, :tag, :data, 'title', 'div',
        [:nut, :attrs, { 'data-prop': 'title' }],
        [:multi, [:static, 'Hello']],
      ],
    )
  end

  def test_nested_property
    assert_parsed(
      '<div data-prop="post"><span data-prop="title"></span></div>',
      [
        :nut, :tag, :data, 'post', 'div',
        [:nut, :attrs, { 'data-prop': 'post' }],
        [
          :multi,
          [
            :nut, :tag, 'post', 'title', 'span',
            [:nut, :attrs, { 'data-prop': 'title' }],
            [:multi],
          ],
        ],
      ],
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
      [
        :nut, :tag, :data, nil, 'ul',
        [:nut, :attrs, {}],
        [
          :multi,
          [
            :nut, :tag, :data, 'post', 'li',
            [:nut, :attrs, { 'data-prop': 'post' }],
            [
              :multi,
              [
                :nut, :tag, 'post', nil, 'div',
                [:nut, :attrs, {}],
                [
                  :multi,
                  [
                    :nut, :tag, 'post', 'title', 'span',
                    [:nut, :attrs, { 'data-prop': 'title' }],
                    [:multi],
                  ],
                ]
              ],
            ],
          ],
        ],
      ],
    )
  end

  private

  def assert_parsed(source, expected)
    actual = Ratchet::Parser.new.call(source)
    assert_equal expected, actual
  end
end
