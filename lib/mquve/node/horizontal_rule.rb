# frozen_string_literal: true

require 'mquve/node/base'

module Mquve
  class Node
    class HorizontalRule < Base
      attr_accessor :children, :inner, :outer, :src, :alt
      attr_reader :parent, :type

      def initialize(content = '', parent = nil)
        @inner = content
        @outer = content
        @parent = parent
        @children = []
        @type = :horizontal_rule
        @src = ''
        @alt = ''
      end

      def outer_html
        "<hr />\n"
      end

      def inlinize
        self
      end
    end
  end
end
