# frozen_string_literal: true

# rubocop:disable Layout/TrailingWhitespace
# rubocop:disable Layout/HeredocIndentation

RSpec.describe 'Indented code blocks' do
  describe 'Simple' do
    it do
      markdown = <<-MARKDOWN
    a simple
      indented code block
      MARKDOWN
      html = <<~HTML
        <pre><code>a simple
          indented code block
        </code></pre>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Simple' do
    it do
      markdown = <<-MARKDOWN
    a simple
      indented code block
      MARKDOWN
      html = <<~HTML
        <pre><code>a simple
          indented code block
        </code></pre>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end
end

# rubocop:enable Layout/TrailingWhitespace
# rubocop:enable Layout/HeredocIndentation
