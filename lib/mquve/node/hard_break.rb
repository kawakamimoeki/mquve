# frozen_string_literal: true

require 'mquve/node/base'

module Mquve
  class Node
    class HardBreak < Base
      attr_accessor :children, :inner, :outer
      attr_reader :parent, :type

      def initialize
        @inner = "\n"
        @outer = "\n"
        @children = []
        @type = :hard_break
      end

      def process!(text)
        match = match(text)
        return false unless match

        true
      end

      def match(text)
        text.match(/^\n/)
      end

      def inner_html
        "\n"
      end

      def inlinize
        self
      end

      alias outer_html inner_html
    end
  end
end
