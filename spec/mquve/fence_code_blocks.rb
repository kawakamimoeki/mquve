# frozen_string_literal: true

# rubocop:disable Layout/HeredocIndentation

RSpec.describe 'Indented code blocks' do
  describe 'Simple' do
    it do
      markdown = <<-MARKDOWN
```
<
  >
```
      MARKDOWN
      html = <<~HTML
        <pre><code>&lt;
          &gt;
        </code></pre>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end
end

# rubocop:enable Layout/HeredocIndentation
