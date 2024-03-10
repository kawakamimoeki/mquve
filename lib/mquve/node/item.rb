# frozen_string_literal: true

require 'mquve/node/base'

module Mquve
  class Node
    class Item < Base
      attr_accessor :children, :outer, :inner, :parent, :ancestor, :type, :depth, :attrs

      def initialize(content: '', parent: nil, attrs: {})
        @outer = content
        @inner = content
        @children = []
        @type = :ordered_list_item
        @attrs = attrs
        @parent = parent
      end

      def outer_html
        "<li>#{parent.attrs[:tight] || children.empty? ? '' : "\n"}#{inner_html}</li>\n"
      end

      alias html outer_html
    end
  end
end
