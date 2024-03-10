# frozen_string_literal: true

require 'mquve/node/base'

module Mquve
  class Node
    class Heading < Base
      attr_accessor :inner, :outer, :children, :level, :attrs
      attr_reader :parent, :type

      def initialize(parent: nil, attrs: {})
        @parent = parent
        @children = []
        @attrs = attrs
      end

      def html
        html(self)
      end

      def outer_html
        "<h#{attrs[:level]}>#{inner_html}</h#{attrs[:level]}>\n"
      end
    end
  end
end
