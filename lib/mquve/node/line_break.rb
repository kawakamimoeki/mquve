# frozen_string_literal: true

require 'mquve/node/base'

module Mquve
  class Node
    class LineBreak < Base
      attr_accessor :children, :inner, :outer
      attr_reader :parent, :type

      def initialize
        @inner = "\n"
        @outer = "\n"
        @children = []
        @type = :line_break
      end

      def inner_html
        '<br />'
      end

      def inlinize
        self
      end

      alias outer_html inner_html
    end
  end
end
