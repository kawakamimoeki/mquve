# frozen_string_literal: true

module Mquve
  class Parser
    class Block
      class SetextHeading
        def process(state)
          match = state.content.match(/^(=+|-+)$/)
          return false unless match && state.in?(::String)

          heading = Node::Heading.new(content: state.bottom, attrs: { level: match[0].include?('=') ? 1 : 2 })
          state.delete!
          state.store!(heading)
          true
        end
      end
    end
  end
end
