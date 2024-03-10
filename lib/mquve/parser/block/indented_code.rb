# frozen_string_literal: true

module Mquve
  class Parser
    class Block
      class IndentedCode
        def process(state)
          match = state.content.match(/^ {4,}(?<content>.*\n)/)
          return state unless match && !state.under?(Node::CodeBlock) && !state.in?(::String)

          3.times { state.close! } if match[0].length < state.indent + 4

          code_block = Node::CodeBlock.new
          state.open!(code_block)
          state.content = match[:content]
          state
        end
      end
    end
  end
end
