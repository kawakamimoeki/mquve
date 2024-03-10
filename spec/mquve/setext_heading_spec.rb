# frozen_string_literal: true

# rubocop:disable Layout/HeredocIndentation

RSpec.describe 'Setext headings' do
  describe 'Simple' do
    it do
      markdown = <<-MARKDOWN
Foo *bar*
=========

Foo *bar*
---------
      MARKDOWN
      html = <<~HTML
        <h1>Foo <em>bar</em></h1>
        <h2>Foo <em>bar</em></h2>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end
end

# rubocop:enable Layout/HeredocIndentation
