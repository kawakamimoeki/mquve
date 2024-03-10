# frozen_string_literal: true

require 'mquve/node/base'

module Mquve
  class Node
    class Italic < Base
      attr_accessor :children, :inner, :outer, :src, :alt
      attr_reader :parent, :type

      def initialize
        super
        @inner = ''
        @outer = ''
        @children = []
        @type = :italic
        @src = ''
        @alt = ''
      end

      def process!(text)
        match = match(text)
        return false unless match

        self.outer = match[0]
        self.inner = match[:content]
        true
      end

      def match(text)
        text.match(/^(\*(?<content>.*?)\*|_(?<content>.*?)_)/)
      end

      def outer_html
        "<i>#{inner_html}</i>"
      end
    end
  end
end
