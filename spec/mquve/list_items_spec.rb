# frozen_string_literal: true

# rubocop:disable Layout/HeredocIndentation

RSpec.describe 'List items' do
  describe 'Simple' do
    xit do
      markdown = <<-MARKDOWN
1.  A paragraph
with two lines.

        indented code

    > A block quote.
      MARKDOWN
      html = <<~HTML
        <ol>
        <li>
        <p>A paragraph
        with two lines.</p>
        <pre><code>indented code
        </code></pre>
        <blockquote>
        <p>A block quote.</p>
        </blockquote>
        </li>
        </ol>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Far content must be indented to be put under the list item' do
    it do
      markdown = <<-MARKDOWN
- one

 two
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>one</li>
        </ul>
        <p>two</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
- one

  two
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>
        <p>one</p>
        <p>two</p>
        </li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    xit do
      markdown = <<-MARKDOWN
 -    one

     two
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>one</li>
        </ul>
        <pre><code> two
        </code></pre>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
 -    one

      two
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>
        <p>one</p>
        <p>two</p>
        </li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Which column this indentation reaches will depend on how the list item is embedded in other constructions, as shown by this example' do
    it do
      markdown = <<-MARKDOWN
   > > 1.  one
>>
>>     two
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <blockquote>
        <ol>
        <li>
        <p>one</p>
        <p>two</p>
        </li>
        </ol>
        </blockquote>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
>>- one
>>
  >  > two
      MARKDOWN
      html = <<~HTML
        <blockquote>
        <blockquote>
        <ul>
        <li>one</li>
        </ul>
        <p>two</p>
        </blockquote>
        </blockquote>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Least one space or tab is needed between the list marker and any following content' do
    it do
      markdown = <<-MARKDOWN
-one

2.two
      MARKDOWN
      html = <<~HTML
        <p>-one</p>
        <p>2.two</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'A list item may contain blocks that are separated by more than one blank line' do
    it do
      markdown = <<-MARKDOWN
- foo


  bar
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>
        <p>foo</p>
        <p>bar</p>
        </li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'A list item may contain any kind of block' do
    xit do
      markdown = <<-MARKDOWN
1.  foo

    ```
    bar
    ```

    baz

    > bam
      MARKDOWN
      html = <<~HTML
        <ol>
        <li>
        <p>foo</p>
        <pre><code>bar
        </code></pre>
        <p>baz</p>
        <blockquote>
        <p>bam</p>
        </blockquote>
        </li>
        </ol>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'A list item that contains an indented code block will preserve empty lines within the code block verbatim' do
    xit do
      markdown = <<-MARKDOWN
- Foo

      bar


      baz
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>
        <p>Foo</p>
        <pre><code>bar


        baz
        </code></pre>
        </li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Ordered list start numbers must be nine digits or less' do
    it do
      markdown = <<-MARKDOWN
123456789. ok
      MARKDOWN
      html = <<~HTML
        <ol>
        <li>ok</li>
        </ol>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
1234567890. not ok
      MARKDOWN
      html = <<~HTML
        <p>1234567890. not ok</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'A start number may begin with 0s' do
    it do
      markdown = <<-MARKDOWN
0. ok
      MARKDOWN
      html = <<~HTML
        <ol>
        <li>ok</li>
        </ol>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
003. ok
      MARKDOWN
      html = <<~HTML
        <ol>
        <li>ok</li>
        </ol>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'A start number may not be negative' do
    it do
      markdown = <<-MARKDOWN
-1. not ok
      MARKDOWN
      html = <<~HTML
        <p>-1. not ok</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'An indented code block will have to be preceded by four spaces of indentation beyond the edge of the region where text will be included in the list item' do
    xit do
      markdown = <<-MARKDOWN
- foo

      bar
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>
        <p>foo</p>
        <pre><code>bar
        </code></pre>
        </li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    xit do
      markdown = <<-MARKDOWN
  10.  foo

           bar
      MARKDOWN
      html = <<~HTML
        <ol>
        <li>
        <p>foo</p>
        <pre><code>bar
        </code></pre>
        </li>
        </ol>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'If the first block in the list item is an indented code block, the contents must be preceded by one space of indentation after the list marker' do
    xit do
      markdown = <<-MARKDOWN
1.     indented code

   paragraph

    more code
      MARKDOWN
      html = <<~HTML
        <ol>
        <li>
        <pre><code>indented code
        </code></pre>
        <p>paragraph</p>
        <pre><code>more code
        </code></pre>
        </li>
        </ol>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end
end

# rubocop:enable Layout/HeredocIndentation
