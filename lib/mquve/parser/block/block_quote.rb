# frozen_string_literal: true

module Mquve
  class Parser
    class Block
      class BlockQuote
        def process(state)
          match = state.content.match(/^(?<mark>(\s*>)+)(?<content>.*\n)$/)
          return false unless match

          state.close! if state.in?(Node::Paragraph)
          if match[:mark].count('>') > state.current_quote.attrs[:depth]
            match[:mark].count('>').times do |i|
              block_quote = Node::BlockQuote.new(attrs: { depth: i + 1 })
              state.open!(block_quote)
            end
          end
          state.content = match[:content]
          false
        end
      end
    end
  end
end
