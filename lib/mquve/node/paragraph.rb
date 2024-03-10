# frozen_string_literal: true

require 'mquve/node/base'

module Mquve
  class Node
    class Paragraph < Base
      PATTERN = /(?<content>.+\n)$/
      EXCLUDED = /^\s*(\#{1,6}|[-*+]\s+|[1-9]+\.\s+|.+\|.+|> |-{3,}|\*{3,}|```|~~~)/

      attr_accessor :children, :outer
      attr_reader :parent, :type

      def initialize(content:, parent: nil, attrs: {})
        @outer = content
        @children = []
        @type = :paragraph
        @parent = parent
        @attrs = attrs
      end

      def self.multiline?
        true
      end

      def inner
        outer.chomp.chomp
      end

      def outer_html
        "<p>#{inner_html}</p>\n"
      end

      alias html outer_html
    end
  end
end
