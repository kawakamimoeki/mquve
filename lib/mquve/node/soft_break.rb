# frozen_string_literal: true

require 'mquve/node/base'

module Mquve
  class Node
    class SoftBreak < Base
      attr_accessor :children, :inner, :outer, :href, :text, :parent, :type

      def initialize(content = '', parent = nil)
        @inner = content
        @outer = content
        @parent = parent
        @children = []
        @type = :soft_break
      end

      def process!(text, _)
        match = match(text)
        return false unless match

        self.outer = text
        self.inner = text
        true
      end

      def match(text)
        text.match(/^\n$/)
      end

      def outer_html
        "\n"
      end
    end
  end
end
