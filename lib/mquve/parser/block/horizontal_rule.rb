# frozen_string_literal: true

module Mquve
  class Parser
    class Block
      class HorizontalRule
        def process(state)
          match = state.content.match(/^(\*{3,}|-{3,})$/)
          return false unless match

          horizontal_rule = Node::HorizontalRule.new
          state.store!(horizontal_rule)
          true
        end
      end
    end
  end
end
