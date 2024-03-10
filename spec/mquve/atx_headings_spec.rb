# frozen_string_literal: true

# rubocop:disable Layout/TrailingWhitespace
# rubocop:disable Layout/HeredocIndentation

RSpec.describe 'ATX headings' do
  describe 'Simple' do
    it do
      markdown = <<~MARKDOWN
        # foo
        ## foo
        ### foo
        #### foo
        ##### foo
        ###### foo
      MARKDOWN
      html = <<~HTML
        <h1>foo</h1>
        <h2>foo</h2>
        <h3>foo</h3>
        <h4>foo</h4>
        <h5>foo</h5>
        <h6>foo</h6>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'More than six # characters is not a heading' do
    it do
      markdown = <<~MARKDOWN
        ####### foo
      MARKDOWN
      html = <<~HTML
        <p>####### foo</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'At least one space or tab is required between the # characters and the heading\'s contents, unless the heading is empty' do
    it do
      markdown = <<~MARKDOWN
        #5 bolt

        #hashtag
      MARKDOWN
      html = <<~HTML
        <p>#5 bolt</p>
        <p>#hashtag</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'The first # is escaped' do
    xit do
      markdown = <<~'MARKDOWN'
        \## foo
      MARKDOWN
      html = <<~HTML
        <p>## foo</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Contents are parsed as inlines' do
    xit do
      markdown = <<~'MARKDOWN'
        # foo *bar* \*baz\*
      MARKDOWN
      html = <<~HTML
        <h1>foo <em>bar</em> *baz*</h1>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Leading and trailing spaces or tabs are ignored in parsing inline content' do
    it do
      markdown = <<~MARKDOWN
        #                  foo                     
      MARKDOWN
      html = <<~HTML
        <h1>foo</h1>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Up to three spaces of indentation are allowed' do
    xit do
      markdown = <<~MARKDOWN
         ### foo
          ## foo
           # foo
      MARKDOWN
      html = <<~HTML
        <h3>foo</h3>
        <h2>foo</h2>
        <h1>foo</h1>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Four spaces of indentation is too many' do
    xit do
      markdown = <<-MARKDOWN
    # foo
      MARKDOWN
      html = <<~HTML
        <pre><code># foo
        </code></pre>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<-MARKDOWN
foo
    # bar
      MARKDOWN
      html = <<~HTML
        <p>foo
        # bar</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'A closing sequence of # characters is optional' do
    it do
      markdown = <<~MARKDOWN
        ## foo ##
        ###   bar    ###
      MARKDOWN
      html = <<~HTML
        <h2>foo</h2>
        <h3>bar</h3>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'It need not be the same length as the opening sequence' do
    it do
      markdown = <<~MARKDOWN
        # foo ##################################
        ##### foo ##
      MARKDOWN
      html = <<~HTML
        <h1>foo</h1>
        <h5>foo</h5>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Spaces or tabs are allowed after the closing sequence' do
    it do
      markdown = <<-MARKDOWN
### foo ###     
      MARKDOWN
      html = <<~HTML
        <h3>foo</h3>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'A sequence of # characters with anything but spaces or tabs following it is not a closing sequence, but counts as part of the contents of the heading' do
    it do
      markdown = <<-MARKDOWN
### foo ### b
      MARKDOWN
      html = <<~HTML
        <h3>foo ### b</h3>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'The closing sequence must be preceded by a space or tab' do
    it do
      markdown = <<~MARKDOWN
        # foo#
      MARKDOWN
      html = <<~HTML
        <h1>foo#</h1>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'Backslash-escaped # characters do not count as part of the closing sequence' do
    xit do
      markdown = <<~'MARKDOWN'
        ### foo \###
        ## foo #\##
        # foo \#
      MARKDOWN
      html = <<~HTML
        <h3>foo ###</h3>
        <h2>foo ###</h2>
        <h1>foo #</h1>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'ATX headings need not be separated from surrounding content by blank lines, and they can interrupt paragraphs' do
    it do
      markdown = <<~MARKDOWN
        ****
        ## foo
        ****
      MARKDOWN
      html = <<~HTML
        <hr />
        <h2>foo</h2>
        <hr />
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end

    it do
      markdown = <<~MARKDOWN
        Foo bar
        # baz
        Bar foo
      MARKDOWN
      html = <<~HTML
        <p>Foo bar</p>
        <h1>baz</h1>
        <p>Bar foo</p>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end

  describe 'ATX headings can be empty' do
    it do
      markdown = <<~MARKDOWN
        ## 
        #
        ### ###
      MARKDOWN
      html = <<~HTML
        <h2></h2>
        <h1></h1>
        <h3></h3>
      HTML
      expect(Mquve.to_html(markdown)).to eq(html)
    end
  end
end

# rubocop:enable Layout/TrailingWhitespace
# rubocop:enable Layout/HeredocIndentation
