# frozen_string_literal: true

require 'mquve/node/base'

module Mquve
  class Node
    class List < Base
      attr_accessor :children, :outer, :inner, :ancestor, :depth, :attrs
      attr_reader :parent, :type

      def initialize(content: '', parent: nil, attrs: {})
        @outer = content
        @inner = content
        @children = []
        @type = :ordered_list
        @parent = parent
        @attrs = attrs
      end

      def outer_html
        "<ol>\n#{inner_html}\n</ol>\n"
      end

      alias html outer_html
    end
  end
end
