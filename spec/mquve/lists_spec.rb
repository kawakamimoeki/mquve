# frozen_string_literal: true

# rubocop:disable Layout/HeredocIndentation

RSpec.describe 'Lists' do
  describe 'Changing the bullet or ordered list delimiter starts a new list' do
    it do
      markdown = <<-MARKDOWN
- foo
- bar
+ baz
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>foo</li>
        <li>bar</li>
        </ul>
        <ul>
        <li>baz</li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
1. foo
2. bar
3) baz
      MARKDOWN
      html = <<~HTML
        <ol>
        <li>foo</li>
        <li>bar</li>
        </ol>
        <ol>
        <li>baz</li>
        </ol>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'A list can interrupt a paragraph' do
    it do
      markdown = <<-MARKDOWN
Foo
- bar
- baz
      MARKDOWN
      html = <<~HTML
        <p>Foo</p>
        <ul>
        <li>bar</li>
        <li>baz</li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'We allow only lists starting with `1` to interrupt paragraphs' do
    it do
      markdown = <<-MARKDOWN
The number of windows in my house is
14.  The number of doors is 6.
      MARKDOWN
      html = <<~HTML
        <p>The number of windows in my house is
        14.  The number of doors is 6.</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
The number of windows in my house is
1.  The number of doors is 6.
      MARKDOWN
      html = <<~HTML
        <p>The number of windows in my house is</p>
        <ol>
        <li>The number of doors is 6.</li>
        </ol>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'There can be any number of blank lines between items' do
    it do
      markdown = <<-MARKDOWN
- foo

- bar


- baz
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>
        <p>foo</p>
        </li>
        <li>
        <p>bar</p>
        </li>
        <li>
        <p>baz</p>
        </li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
- foo
  - bar
    - baz


      bim
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>foo
        <ul>
        <li>bar
        <ul>
        <li>
        <p>baz</p>
        <p>bim</p>
        </li>
        </ul>
        </li>
        </ul>
        </li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'To separate consecutive lists of the same type, or to separate a list from an indented code block that would otherwise be parsed as a subparagraph of the final list item, you can insert a blank HTML comment' do
    it do
      markdown = <<-MARKDOWN
- foo
- bar

<!-- -->

- baz
- bim
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>foo</li>
        <li>bar</li>
        </ul>
        <!-- -->
        <ul>
        <li>baz</li>
        <li>bim</li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
-   foo

    notcode

-   foo

<!-- -->

    code
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>
        <p>foo</p>
        <p>notcode</p>
        </li>
        <li>
        <p>foo</p>
        </li>
        </ul>
        <!-- -->
        <pre><code>code
        </code></pre>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'The following list items will be treated as items at the same list level, since none is indented enough to belong to the previous list item' do
    it do
      markdown = <<-MARKDOWN
- a
 - b
  - c
   - d
  - e
 - f
- g
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>a</li>
        <li>b</li>
        <li>c</li>
        <li>d</li>
        <li>e</li>
        <li>f</li>
        <li>g</li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
1. a

  2. b

   3. c
      MARKDOWN
      html = <<~HTML
        <ol>
        <li>
        <p>a</p>
        </li>
        <li>
        <p>b</p>
        </li>
        <li>
        <p>c</p>
        </li>
        </ol>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe ' List items may not be preceded by more than three spaces of indentation' do
    it do
      markdown = <<-MARKDOWN
- a
 - b
  - c
   - d
    - e
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>a</li>
        <li>b</li>
        <li>c</li>
        <li>d
        - e</li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'List items may not be preceded by more than three spaces of indentation' do
    it do
      markdown = <<-MARKDOWN
1. a

  2. b

    3. c
      MARKDOWN
      html = <<~HTML
        <ol>
        <li>
        <p>a</p>
        </li>
        <li>
        <p>b</p>
        </li>
        </ol>
        <pre><code>3. c
        </code></pre>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'This is a loose list, because there is a blank line between two of the list items' do
    it do
      markdown = <<-MARKDOWN
- a
- b

- c
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>
        <p>a</p>
        </li>
        <li>
        <p>b</p>
        </li>
        <li>
        <p>c</p>
        </li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
* a
*

* c
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>
        <p>a</p>
        </li>
        <li></li>
        <li>
        <p>c</p>
        </li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'These are loose lists, even though there are no blank lines between the items, because one of the items directly contains two block-level elements with a blank line between them' do
    it do
      markdown = <<-MARKDOWN
- a
- b

  c
- d
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>
        <p>a</p>
        </li>
        <li>
        <p>b</p>
        <p>c</p>
        </li>
        <li>
        <p>d</p>
        </li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'This is a tight list, because the blank lines are in a code block' do
    it do
      markdown = <<-MARKDOWN
- a
- ```
  b


  ```
- c
      MARKDOWN
      html = <<-HTML
<ul>
<li>a</li>
<li>
<pre><code>b


</code></pre>
</li>
<li>c</li>
</ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'This is a tight list, because the blank line is between two paragraphs of a sublist. So the sublist is loose while the outer list is tight' do
    it do
      markdown = <<-MARKDOWN
- a
  - b

    c
- d
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>a
        <ul>
        <li>
        <p>b</p>
        <p>c</p>
        </li>
        </ul>
        </li>
        <li>d</li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'This is a tight list, because the blank line is inside the block quote' do
    it do
      markdown = <<-MARKDOWN
* a
  > b
  >
* c
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>a
        <blockquote>
        <p>b</p>
        </blockquote>
        </li>
        <li>c</li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'This is a tight list, because the blank line is inside the block quote' do
    it do
      markdown = <<-MARKDOWN
- a
  > b
  ```
  c
  ```
- d
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>a
        <blockquote>
        <p>b</p>
        </blockquote>
        <pre><code>c
        </code></pre>
        </li>
        <li>d</li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'A single-paragraph list is tight' do
    it do
      markdown = <<-MARKDOWN
- a
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>a</li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
- a
  - b
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>a
        <ul>
        <li>b</li>
        </ul>
        </li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Here the outer list is loose, the inner list tight' do
    it do
      markdown = <<-MARKDOWN
* foo
  * bar

  baz
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>
        <p>foo</p>
        <ul>
        <li>bar</li>
        </ul>
        <p>baz</p>
        </li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
- a
  - b
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>a
        <ul>
        <li>b</li>
        </ul>
        </li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Here the outer list is loose, the inner list tight' do
    it do
      markdown = <<-MARKDOWN
* foo
  * bar

  baz
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>
        <p>foo</p>
        <ul>
        <li>bar</li>
        </ul>
        <p>baz</p>
        </li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
- a
  - b
  - c

- d
  - e
  - f
      MARKDOWN
      html = <<~HTML
        <ul>
        <li>
        <p>a</p>
        <ul>
        <li>b</li>
        <li>c</li>
        </ul>
        </li>
        <li>
        <p>d</p>
        <ul>
        <li>e</li>
        <li>f</li>
        </ul>
        </li>
        </ul>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end
end

# rubocop:enable Layout/HeredocIndentation
