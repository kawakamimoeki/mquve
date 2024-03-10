# frozen_string_literal: true

require 'mquve/node/code_block'

module Mquve
  class Parser
    class OpenNodes
      attr_accessor :parent, :nodes

      def initialize(nodes:, parent:)
        @nodes = nodes
        @parent = parent
      end

      def close!
        return if nodes.length < 2

        node = nodes.pop
        store!(node)
      end

      def has_block?
        nodes.length > 1 && !has_text?
      end

      def has_text?
        bottom.instance_of?(String)
      end

      def in?(type)
        bottom.instance_of?(type)
      end

      def bottom
        nodes[-1]
      end

      def open!(target)
        nodes << target
      end

      def store!(target)
        if has_text?
          nodes[-1] += target
          return
        end

        target = Node::Paragraph.new(content: target.gsub(/^\s*/, '').strip.gsub(/\s{2,}\n/, "<br />\n"), parent: parent) if target.instance_of?(String)

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
