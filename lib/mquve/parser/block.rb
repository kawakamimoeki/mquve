# frozen_string_literal: true

require 'mquve/node/heading'
require 'mquve/node/paragraph'
require 'mquve/node/code_block'
require 'mquve/node/horizontal_rule'
require 'mquve/node/block_quote'
require 'mquve/parser/open_nodes'
require 'mquve/node/item'
require 'mquve/node/list'

module Mquve
  class Parser
    class Block
      def process(parent)
        opens = OpenNodes.new(parent: parent, nodes: [parent])

        parent.content.lines.each_with_index do |line, i|
          if opens.in?(Node::CodeBlock) && opens.bottom.attrs[:info]
            if (match = line.match(/^ {,3}(```(?<info>.*?)|~~~(?<info>.*?))\n$/))
              opens.close!
              next
            end

            opens.bottom.inner += line
            next
          end
          if line == "\n"
            opens.close! until opens.in?(Node::Document) || opens.in?(Node::Item)
            next
          end
          if (match = line.match(/^ {,3}(```(?<info>.*?)|~~~(?<info>.*?))\n$/))
            opens.close!
            code_block = Node::CodeBlock.new(content: line.chomp, attrs: { info: match[:info] })
            opens.open!(code_block)
            next
          end
          if (match = line.match(/^(?<quote>( {,3}>(?<space> *))+).*/))
            depth = match[:quote].count('>')
            max_depth = opens.nodes.map { _1.instance_of?(Node::BlockQuote) ? _1.attrs[:depth] : 0 }.max
            if depth > max_depth
              opens.close!
              block_quote = Node::BlockQuote.new(content: '', parent: parent, attrs: { depth: depth })
              opens.open!(block_quote)
            end
            opens.close! until opens.in?(Node::BlockQuote) && opens.bottom.attrs[:depth] == depth if max_depth.positive? && depth < max_depth
            line = line[match[:quote].length..]
          end
          if (match = line.match(/^ {,3}(?<num>[0-9]+)\.\s+(?<content>.*\n)/))
            list = Node::List.new(attrs: { start: match[:num], type: :ordered, delimiter: :period })
            opens.open!(list)
            item = Node::Item.new
            opens.open!(item)
            line = match[:content]
          end
          if (match = line.match(/^ {,3}(?<level>\#{1,6}) *(?<content>.*)\n/))
            opens.close!
            heading = Node::Heading.new(content: match[:content], parent: parent, attrs: { level: match[:level].length })
            opens.store!(heading)
            next
          end
          if opens.has_text? && line.match(/^=+\n/)
            opens.close!
            heading = Node::Heading.new(content: opens.bottom, parent: parent, attrs: { level: 1 })
            opens.store!(heading)
            next
          end
          if opens.has_text? && line.match(/^-+\n/)
            opens.close!
            heading = Node::Heading.new(content: opens.bottom, parent: parent, attrs: { level: 2 })
            opens.store!(heading)
            next
          end
          if !opens.has_text? && (match = line.match(/^(?<indent> {4,})(?<content>.*\n)/))
            opens.close!
            if opens.in?(Node::CodeBlock)
              opens.bottom.inner += match[0][4..]
            else
              code_block = Node::CodeBlock.new(content: match[:content])
              opens.open!(code_block)
              next
            end
          end

          opens.close! if opens.in?(Node::CodeBlock) && !opens.bottom.attrs[:info]
          opens.store_or_open!(line)
          opens.close! while opens.nodes.length > 1 if i == parent.content.lines.length - 1
        end

        parent
      end
    end
  end
end
