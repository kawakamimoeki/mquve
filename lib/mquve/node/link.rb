# frozen_string_literal: true

require 'mquve/node/base'

module Mquve
  class Node
    class Link < Base
      attr_accessor :children, :inner, :outer, :href, :text
      attr_reader :parent, :type

      def initialize
        super
        @inner = ''
        @outer = ''
        @children = []
        @type = :link
        @href = ''
        @text = ''
      end

      def process!(text)
        match = match(text)
        return false unless match

        self.outer = match[0]
        self.inner = match[:text]
        self.href = match[:href]
        self.text = match[:text]
        true
      end

      def match(text)
        text.match(/^\[(?<text>.*)\]\((?<href>.*)\)/)
      end

      def outer_html
        "<a href=\"#{href}\">#{inner_html}</a>"
      end
    end
  end
end
