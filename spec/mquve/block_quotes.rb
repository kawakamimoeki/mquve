# frozen_string_literal: true

# rubocop:disable Layout/TrailingWhitespace
# rubocop:disable Layout/HeredocIndentation

RSpec.describe 'Block quotes' do
  describe 'Simple' do
    it do
      markdown = <<-MARKDOWN
> # Foo
> bar
> baz
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <h1>Foo</h1>
        <p>bar
        baz</p>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'The space or tab after the > characters can be omitted' do
    it do
      markdown = <<-MARKDOWN
># Foo
>bar
> baz
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <h1>Foo</h1>
        <p>bar
        baz</p>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'The `>` characters can be preceded by up to three spaces of indentation' do
    it do
      markdown = <<-MARKDOWN
  > # Foo
  > bar
> baz
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <h1>Foo</h1>
        <p>bar
        baz</p>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Four spaces of indentation is too many' do
    it do
      markdown = <<-MARKDOWN
    > # Foo
    > bar
    > baz
      MARKDOWN
      html = <<~HTML
        <pre><code>&gt; # Foo
        &gt; bar
        &gt; baz
        </code></pre>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'The Laziness clause allows us to omdescribe the `>` before paragraph 
  docontinuation text' do
    it do
      markdown = <<-MARKDOWN
> # Foo
> bar
baz
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <h1>Foo</h1>
        <p>bar
        baz</p>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'A block quote can contain some lazy and some non-lazy continuation lines' do
    it do
      markdown = <<-MARKDOWN
> bar
baz
> foo
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <p>bar
        baz
        foo</p>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Laziness only applies to lines that would have been continuations of 
  doparagraphs had they been prepended with block quote markers' do
    it do
      markdown = <<-MARKDOWN
> foo
---
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <p>foo</p>
        </blockquote>
        <hr />
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
> - foo
- bar
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <ul>
        <li>foo</li>
        </ul>
        </blockquote>
        <ul>
        <li>bar</li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'We can\'t omit the > in front of subsequent lines of an indented or fenced code block' do
    it do
      markdown = <<-MARKDOWN
>     foo
    bar
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <pre><code>foo
        </code></pre>
        </blockquote>
        <pre><code>bar
        </code></pre>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
> ```
foo
```
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <pre><code></code></pre>
        </blockquote>
        <p>foo</p>
        <pre><code></code></pre>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
> foo
    - bar
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <p>foo
        - bar</p>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'A block quote can be empty' do
    it do
      markdown = <<-MARKDOWN
>
      MARKDOWN
      html = <<~HTML
        <blockquote>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
>
>  
> 
      MARKDOWN
      html = <<~HTML
        <blockquote>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'A block quote can have initial or final blank lines' do
    it do
      markdown = <<-MARKDOWN
>
> foo
>  
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <p>foo</p>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'A blank line always separates block quotes' do
    it do
      markdown = <<-MARKDOWN
> foo

> bar
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <p>foo</p>
        </blockquote>
        <blockquote>
        <p>bar</p>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'If we put these block quotes together, we get a single block quote' do
    it do
      markdown = <<-MARKDOWN
> foo
> bar
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <p>foo
        bar</p>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'If we put blank lines, we get a block quote with two paragraphs' do
    it do
      markdown = <<-MARKDOWN
> foo
>
> bar
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <p>foo</p>
        <p>bar</p>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Block quotes can interrupt paragraphs' do
    it do
      markdown = <<-MARKDOWN
foo
> bar
      MARKDOWN
      html = <<~HTML
        <p>foo</p>
        <blockquote>
        <p>bar</p>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'In general, blank lines are not needed before or after block quotes' do
    it do
      markdown = <<-MARKDOWN
> aaa
***
> bbb
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <p>aaa</p>
        </blockquote>
        <hr />
        <blockquote>
        <p>bbb</p>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'A blank line is needed between a block quote and a following paragraph' do
    it do
      markdown = <<-MARKDOWN
> bar
baz
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <p>bar
        baz</p>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
    
    it do
      markdown = <<-MARKDOWN
> bar

baz
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <p>bar</p>
        </blockquote>
        <p>baz</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
> bar
>
baz
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <p>bar</p>
        </blockquote>
        <p>baz</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Any number of initial >s may be omitted on a continuation line of a nested block quote' do
    it do
      markdown = <<-MARKDOWN
> > > foo
bar
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <blockquote>
        <blockquote>
        <p>foo
        bar</p>
        </blockquote>
        </blockquote>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
>>> foo
> bar
>>baz
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <blockquote>
        <blockquote>
        <p>foo
        bar
        baz</p>
        </blockquote>
        </blockquote>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'The block quote marker includes both the `>` and a following space of indentation' do
    it do
      markdown = <<-MARKDOWN
>     code

>    not code
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <pre><code>code
        </code></pre>
        </blockquote>
        <blockquote>
        <p>not code</p>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end
end

# rubocop:enable Layout/TrailingWhitespace
# rubocop:enable Layout/HeredocIndentation
