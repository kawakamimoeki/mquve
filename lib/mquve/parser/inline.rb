# frozen_string_literal: true

module Mquve
  class Parser
    class Inline
      TYPES = [Node::Text, Node::LineBreak, Node::Bold, Node::Link, Node::CodeSpan, Node::Image, Node::Italic, Node::Strikethrough].freeze

      def self.process(parent)
        i = 0
        loop do
          TYPES.any? do |type|
            node = type.new
            status = node.process!(parent.inner[i..])

            next false unless status

            parent.children << node.inlinize
            i += node.outer.length - 1
            true
          end

          break if i > parent.inner.length - 1

          i += 1
        end

        parent
      end
    end
  end
end
