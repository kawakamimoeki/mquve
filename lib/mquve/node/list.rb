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

      def tag
        attrs[:type] == :ordered ? 'ol' : 'ul'
      end

      def outer_html
        "#{parent.instance_of?(Node::Item) && parent.parent.attrs[:tight] ? "\n" : ''}<#{tag}>\n#{inner_html}</#{tag}>\n"
      end

      alias html outer_html
    end
  end
end
