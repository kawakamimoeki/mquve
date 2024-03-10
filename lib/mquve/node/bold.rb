# frozen_string_literal: true

module Mquve
  class Node
    class Bold < Base
      attr_accessor :children, :inner, :outer
      attr_reader :parent, :type

      def initialize
        super
        @inner = ''
        @outer = ''
        @children = []
        @type = :bold
      end

      def process!(text)
        match = match(text)
        return false unless match

        self.outer += match[0]
        self.inner += match[:content]
        true
      end

      def match(text)
        text.match(/^(\*{2}(?<content>.*)\*{2}|_{2}(?<content>.*)_{2})/)
      end

      def outer_html
        "<strong>#{inner_html}</strong>"
      end
    end
  end
end
