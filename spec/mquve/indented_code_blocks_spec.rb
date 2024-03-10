# frozen_string_literal: true

RSpec.describe 'Indented code blocks' do
  describe 'Simple' do
    xit do
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
