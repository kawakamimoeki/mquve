# frozen_string_literal: true

require 'mquve/node/text'
require 'mquve/node/base'

module Mquve
  class Node
    class CodeBlock < Base
      attr_accessor :children, :label, :mark, :inner, :outer, :attrs
      attr_reader :parent, :type

      def initialize(content: '', parent: nil, attrs: {})
        @inner = content
        @outer = content
        @children = []
        @type = :code_block
        @attrs = attrs
        @parent = parent
      end

      def outer_html
        "<pre><code#{attrs[:info] && !attrs[:info].empty? ? " class=\"language-#{attrs[:info]}\"" : ''}>#{CGI.escapeHTML(text)}</code></pre>\n"
      end

      def text
        children[0].inner
      end
    end
  end
end
