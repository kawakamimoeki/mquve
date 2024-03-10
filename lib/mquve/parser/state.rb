# frozen_string_literal: true

module Mquve
  class Parser
    class State
      attr_accessor :nodes, :content, :list_widable

      def initialize(nodes:)
        @nodes = nodes
        @content = ''
        @list_widable = false
      end

      def delete!
        nodes.pop
      end

      def close!
        return if nodes.length < 2

        node = delete!
        store!(node)
        node
      end

      def has_block?
        nodes.length > 1 && !has_text?
      end

      def indent
        current_item.attrs[:indent]
      end

      def current_list
        nodes.reverse.find { _1.instance_of?(Node::List) } || nodes[0]
      end

      def current_item
        nodes.reverse.find { _1.instance_of?(Node::Item) } || nodes[0]
      end

      def current_quote
        nodes.reverse.find { _1.instance_of?(Node::BlockQuote) } || nodes[0]
      end

      def depth
        current_quote.attrs[:depth]
      end

      def has_text?
        bottom.instance_of?(::String)
      end

      def in?(type)
        bottom.instance_of?(type)
      end

      def under?(type)
        classes.reverse.find { _1 == type }
      end

      def bottom
        nodes[-1]
      end

      def open!(target)
        nodes << target
      end

      def store!(target)
        if target.instance_of?(::String)
          bottom.inner += target
          return
        end

        target.children.pop if target.instance_of?(Node::Paragraph) && target.children.last.instance_of?(Mquve::Node::LineBreak)

        bottom.children << target.inlinize
      end

      def store_or_open!(target)
        has_text? ? store!(target) : open!(target)
      end

      def classes
        nodes.map(&:class)
      end
    end
  end
end
