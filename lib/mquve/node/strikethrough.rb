# frozen_string_literal: true

require 'mquve/node/base'

module Mquve
  class Node
    class Strikethrough < Base
      attr_accessor :children, :inner, :outer
      attr_reader :parent, :type

      def initialize
        super
        @inner = ''
        @outer = ''
        @children = []
        @type = :strikethrough
      end

      def process!(text)
        match = match(text)
        return false unless match

        self.outer = match[0]
        self.inner = match[:content]
        true
      end

      def match(text)
        text.match(/^~~(?<content>.*?)~~/)
      end

      def outer_html
        "<del>#{inner_html}</del>"
      end
    end
  end
end
