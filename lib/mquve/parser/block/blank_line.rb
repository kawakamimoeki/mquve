# frozen_string_literal: true

module Mquve
  class Parser
    class Block
      class BlankLine
        def process(state)
          match = state.content.match(/^\n$/)
          return false unless match

          state.close! if state.in?(Node::Paragraph)

          state.list_widable = true if state.under?(Node::List) && !state.under?(Node::CodeBlock) && !state.under?(Node::BlockQuote)

          state.store!(match[0]) if state.under?(Node::CodeBlock)

          true
        end
      end
    end
  end
end
