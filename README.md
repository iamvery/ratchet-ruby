# Ratchet

[![Build Status][travis-img]][travis]

[travis-img]: https://travis-ci.org/iamvery/ratchet-ruby.svg?branch=master
[travis]: https://travis-ci.org/iamvery/ratchet-ruby

Ratchet is a friendly little transformer that's here to fix your views.

Given a plain HTML view template like this:

```html
<section>
  <article data-prop="post">
    <h2 data-prop="title"></h2>
    <p data-prop="body"></p>
    <a data-prop="permalink"></a>
    <ul>
      <li data-prop="comments"></li>
    </ul>
  </article>
</section>
```

It can be transformed into your final view by applying data:

```ruby
require 'ratchet/data'
include Ratchet::Data

data = {
  post: [
    {title: "Ratchet is here!", body: "Hope you like it", permalink: C("Iamvery", href: "https://iamvery.com"), comments: ["Not bad"]},
    {title: "Robots", body: "What's the deal with them?", permalink: C("Google", href: "https://google.com"), comments: ["Yea!", "Nah"]},
  ]
}
```

```html
<section>
  <article data-prop="post">
    <h2 data-prop="title">Ratchet is here!</h2>
    <p data-prop="body">Hope you like it</p>
    <a href="https://iamvery.com" data-prop="permalink">Iamvery</a>
    <ul>
      <li data-prop="comments">Not bad</li>
    </ul>
  </article>
  <article data-prop="post">
    <h2 data-prop="title">Robots</h2>
    <p data-prop="body">What's the deal with them?</p>
    <a href="https://google.com" data-prop="permalink">Google</a>
    <ul>
      <li data-prop="comments">Yea!</li>
      <li data-prop="comments">Nah</li>
    </ul>
  </article>
</section>
```

## Installation

1. Add to your Gemfile:

   ```ruby
   gem 'ratchet-ruby', github: 'iamvery/ratchet'
   ```

## Background

Ratchet is inspired by [Pakyow's][pakyow] [view transformation protocol][vtp].
One of the benefits of this style of view templates is designers don't have to learn whatever the latest templating language.
Instead views are plain HTML and CSS.
Once you get an HTML prototype from design, you can sprinkle in the appropriate properties for data binding.

See also [Ratchet for Elixir and Phoenix][ratchet-elixir].


[pakyow]: https://pakyow.org
[vtp]: https://pakyow.org/docs/concepts/view-transformation-protocol
[ratchet-elixir]: https://github.com/iamvery/ratchet
