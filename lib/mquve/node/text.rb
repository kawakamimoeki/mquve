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

      alias outer inner
      alias inner_html inner
      alias outer_html inner

      def inlinize
        self
      end
    end
  end
end
