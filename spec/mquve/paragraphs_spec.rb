# frozen_string_literal: true

# rubocop:disable Layout/TrailingWhitespace
# rubocop:disable Layout/HeredocIndentation

RSpec.describe 'Paragraphs' do
  describe 'Simple' do
    it do
      markdown = <<-MARKDOWN
aaa

bbb
      MARKDOWN
      html = <<~HTML
        <p>aaa</p>
        <p>bbb</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Paragraphs can contain multiple lines, but no blank lines' do
    it do
      markdown = <<-MARKDOWN
aaa
bbb

ccc
ddd
      MARKDOWN
      html = <<~HTML
          <p>aaa
          bbb</p>
          <p>ccc
          ddd</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Multiple blank lines between paragraphs have no effect' do
    it do
      markdown = <<-MARKDOWN
aaa


bbb
      MARKDOWN
      html = <<~HTML
        <p>aaa</p>
        <p>bbb</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Leading spaces or tabs are skipped' do
    it do
      markdown = <<-MARKDOWN
  aaa
 bbb
      MARKDOWN
      html = <<~HTML
        <p>aaa
        bbb</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Lines after the first may be indented any amount, since indented code blocks cannot interrupt paragraphs' do
    it do
      markdown = <<-MARKDOWN
aaa
          bbb
                          ccc
      MARKDOWN
      html = <<~HTML
        <p>aaa
        bbb
        ccc</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'However, the first line may be preceded by up to three spaces of indentation. Four spaces of indentation is too many' do
    it do
      markdown = <<-MARKDOWN
    aaa
bbb
      MARKDOWN
      html = <<~HTML
        <pre><code>aaa
        </code></pre>
        <p>bbb</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Final spaces or tabs are stripped before inline parsing, so a paragraph that ends with two or more spaces will not end with a hard line break' do
    it do
      markdown = <<-MARKDOWN
aaa     
bbb     
      MARKDOWN
      html = <<~HTML
        <p>aaa<br />
        bbb</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end
end

# rubocop:enable Layout/TrailingWhitespace
# rubocop:enable Layout/HeredocIndentation
