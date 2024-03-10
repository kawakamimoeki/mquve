# frozen_string_literal: true

require 'mquve/node/base'

module Mquve
  class Node
    class Text < Base
      attr_accessor :children, :inner
      attr_reader :parent, :type

      def initialize(content = '')
        @inner = content
        @type = :text
        @children = []
      end

      def process!(text)
        match = match(text)

        return false unless match

        self.inner = match[:content]
        true
      end

      def match(text)
        match = text.match(/^(?<content>.*?)((!\[|\[|\*|~~|_|`|$|\n|\s:))/)
        return nil unless match
        return nil if match[:content].empty?
        return nil if match[:content].match?(/^(!\[|\[|\*|_|~~|!\[|`|\n)/)
        return nil if match[:content].match?(/.*!$/) && match[2] && match[2].match?(/~\[/)

        match
      end

      alias outer inner
      alias inner_html inner
      alias outer_html inner

      def inlinize
        self
      end
    end
  end
end
