# frozen_string_literal: true

module Mquve
  class Node
    class Document < Base
      attr_accessor :content, :children, :inner, :attrs
      attr_reader :parent, :type

      def initialize(content = '', attrs: { base: 0, indent: 0, marker: 0, space: 0, depth: 0 })
        @content = content
        @children = []
        @type = :document
        @inner = content
        @attrs = attrs
      end

      def nestable?
        true
      end

      def match(line)
        line
      end

      alias outer_html inner_html
    end
  end
end
