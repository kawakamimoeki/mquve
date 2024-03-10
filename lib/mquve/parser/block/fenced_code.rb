# frozen_string_literal: true

module Mquve
  class Parser
    class Block
      class FencedCode
        def process(state)
          match = state.content.match(/^ *(```|~~~)(?<info>.*)\n$/)
          return false unless match

          if state.under?(Node::CodeBlock)
            2.times { state.close! }
            return true
          end
          state.close! if state.in?(Node::Paragraph)
          code_block = Node::CodeBlock.new(attrs: { info: match[:info] })
          state.open!(code_block)
          true
        end
      end
    end
  end
end
