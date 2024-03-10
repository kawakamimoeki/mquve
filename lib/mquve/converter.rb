# frozen_string_literal: true

module Mquve
  class Converter
    def self.process(text)
      doc = Mquve::Node::Document.new(text.gsub(/\t/, "\s\s"))
      doc = Mquve::Parser.process(doc)
      doc.html
    end
  end
end
