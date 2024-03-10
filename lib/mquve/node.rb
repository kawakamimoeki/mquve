# frozen_string_literal: true

require 'cgi'
require 'strscan'

module Mquve
  class Node
    attr_reader :type, :attrs, :parent
    attr_accessor :children, :source

    def initialize(type:, parent: nil, children: [], attrs: {})
      @type = type
      @children = children
      @attrs = attrs
      @parent = parent
    end
  end
end
