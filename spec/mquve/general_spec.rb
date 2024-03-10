# frozen_string_literal: true

# rubocop:disable Layout/TrailingWhitespace
# rubocop:disable Layout/HeredocIndentation

RSpec.describe 'Indented code blocks' do
  describe 'Simple' do
    it do
      markdown = <<-MARKDOWN
# Foo
bar
> baz
> qux
> > quux
> > waldo
> > > corge
> fred

grault
```
garply
```
      MARKDOWN
      html = <<~HTML
        <h1>Foo</h1>
        <p>bar</p>
        <blockquote>
        <p>baz
        qux</p>
        <blockquote>
        <p>quux
        waldo</p>
        <blockquote>
        <p>corge</p>
        </blockquote>
        </blockquote>
        <p>fred</p>
        </blockquote>
        <p>grault</p>
        <pre><code>garply
        </code></pre>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end
end

# rubocop:enable Layout/TrailingWhitespace
# rubocop:enable Layout/HeredocIndentation
