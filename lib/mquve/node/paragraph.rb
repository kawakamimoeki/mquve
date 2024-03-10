# frozen_string_literal: true

require 'mquve/node/base'

module Mquve
  class Node
    class Paragraph < Base
      attr_accessor :children, :outer, :inner
      attr_reader :parent, :type

      def initialize(parent: nil, attrs: {})
        @children = []
        @type = :paragraph
        @parent = parent
        @attrs = attrs
      end

      def self.multiline?
        true
      end

      def outer_html
        h = inner_html
        if parent.instance_of?(Item) && parent.parent.attrs[:tight]
          return "#{h}\n" if parent.children.length > 1

          return h
        end

        "<p>#{inner_html.chomp}</p>\n"
      end

      alias html outer_html
    end
  end
end
