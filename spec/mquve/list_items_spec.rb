# frozen_string_literal: true

# rubocop:disable Layout/TrailingWhitespace
# rubocop:disable Layout/HeredocIndentation

RSpec.describe 'Indented code blocks' do
  describe 'Simple' do
    it do
      markdown = <<-MARKDOWN
aa
      aaa
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
end

# rubocop:enable Layout/TrailingWhitespace
# rubocop:enable Layout/HeredocIndentation
