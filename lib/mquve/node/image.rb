# frozen_string_literal: true

require 'mquve/node/base'

module Mquve
  class Node
    class Image < Base
      attr_accessor :children, :inner, :outer, :src, :alt
      attr_reader :parent, :type

      def initialize
        super
        @inner = ''
        @outer = ''
        @children = []
        @type = :image
        @src = ''
        @alt = ''
      end

      def process!(text)
        match = match(text)
        return false unless match

        self.outer = match[0]
        self.inner = match[0]
        self.src = match[:src]
        self.alt = match[:alt]
        true
      end

      def match(text)
        text.match(/^!\[(?<alt>.*)\]\((?<src>.*)\)/)
      end

      def outer_html
        "<img src=\"#{src}\" alt=\"#{alt}\" />"
      end

      def inlinize
        self
      end
    end
  end
end
