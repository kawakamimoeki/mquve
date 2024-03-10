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
        match = text.match(/^(\*(?<content>.*?)\*|_(?<content>.*?)_)/)
        return nil unless match
        return nil if match[:content].match(/\\$/)

        match
      end

      def outer_html
        "<em>#{inner_html}</em>"
      end
    end
  end
end
