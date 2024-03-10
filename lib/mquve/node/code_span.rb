# frozen_string_literal: true

require 'mquve/node/base'
require 'cgi'

module Mquve
  class Node
    class CodeSpan < Base
      attr_accessor :children, :inner, :outer
      attr_reader :parent, :type

      def initialize
        @inner = ''
        @outer = ''
        @children = []
        @type = :bold
      end

      def process!(text)
        match = text.match(/^`{1,}/)
        return false unless match

        match = text.match(/^`{#{match[0].length}}(?<content>.*?)`{#{match[0].length}}/m)

        return false unless match

        content = match[:content]
        content = content.gsub(/\n/, "\s")
        content = content.gsub(/^ /, '').gsub(/ $/, '') if content.match(/^ .+ $/)

        self.outer += match[0]
        self.inner += content
        true
      end

      def outer_html
        "<code>#{CGI.escapeHTML(inner)}</code>"
      end
    end
  end
end
