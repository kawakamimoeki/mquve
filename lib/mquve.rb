# frozen_string_literal: true

require_relative 'mquve/parser/open_nodes'
require_relative 'mquve/node/base'
require_relative 'mquve/node/bold'
require_relative 'mquve/node/italic'
require_relative 'mquve/node/strikethrough'
require_relative 'mquve/node/hard_break'
require_relative 'mquve/node/link'
require_relative 'mquve/node/image'
require_relative 'mquve/node/code_span'
require_relative 'mquve/node/text'
require_relative 'mquve/node/list'
require_relative 'mquve/version'
require_relative 'mquve/converter'
require_relative 'mquve/parser'

module Mquve
  class Error < StandardError; end

  def self.to_html(text)
    raise TypeError, "Text must be a String; got a #{text.class}." unless text.is_a?(String)
    raise TypeError, "Text must be UTF-8 encoded; got #{text.encoding}." unless text.encoding.name == 'UTF-8'

    Converter.process(text)
  end

  def self.parse(text, &block)
    doc = Node.new(type: :document, source: { content: text, begin: 0, end: text.length - 1 })
    doc = Parser.process(doc)
    call_children(doc, block)
  end

  def self.call_children(parent, block)
    parent.children.each do |child|
      block.call(child)
      call_children(child, block)
    end
  end

  def self.to_document(text)
    doc = Node::Document.new(text)
    Parser.process(doc)
  end
end
