# frozen_string_literal: true

require 'mquve/node/text'
require 'mquve/node/base'

module Mquve
  class Node
    class IndentedCodeBlock < Base
      attr_accessor :children, :label, :mark, :inner, :outer
      attr_reader :parent, :type

      def initialize(content = '', parent = nil)
        @inner = content
        @outer = content
        @children = []
        @type = :code_block
        @label = nil
        @mark = nil
        @parent = parent
      end

      def outer_html
        "<pre><code>#{inner_html}</code></pre>\n"
      end
    end
  end
end
