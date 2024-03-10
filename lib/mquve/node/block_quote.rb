# frozen_string_literal: true

require 'mquve/node/base'

module Mquve
  class Node
    class BlockQuote < Base
      attr_accessor :children, :outer, :inner, :ancestor, :depth, :parent, :type, :attrs

      def initialize(content: '', parent: nil, attrs: {})
        @outer = content
        @inner = content
        @children = []
        @type = :block_quote
        @parent = parent
        @attrs = attrs
      end

      def outer_html
        "<blockquote>\n#{inner_html}</blockquote>\n"
      end

      alias html outer_html
    end
  end
end
