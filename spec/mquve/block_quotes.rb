# frozen_string_literal: true

# rubocop:disable Layout/TrailingWhitespace
# rubocop:disable Layout/HeredocIndentation

RSpec.describe 'Indented code blocks' do
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
end

# rubocop:enable Layout/TrailingWhitespace
# rubocop:enable Layout/HeredocIndentation
