# frozen_string_literal: true

module Mquve
  class Node
    class Document < Base
      attr_accessor :content, :children, :inner
      attr_reader :parent, :type

      def initialize(content = '')
        @content = content
        @children = []
        @type = :document
        @inner = content
      end

      def nestable?
        true
      end

      def match(line)
        line
      end

      alias outer_html inner_html
    end
  end
end
