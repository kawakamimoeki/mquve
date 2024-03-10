# frozen_string_literal: true

module Mquve
  class Parser
    class Block
      class String
        def process(state)
          state.current_list.attrs[:tight] = false if state.current_list && state.current_list.attrs[:widable]

          state.store!(Node::SoftBreak.new) if state.in?(Node::Paragraph) && !state.bottom.children.empty?

          content = state.content
          content = content.gsub(/^ */, '').gsub(/ *$/, '') if state.in?(Node::Paragraph)
          content = content.chomp unless state.in?(Node::CodeBlock)

          if state.under?(Node::CodeBlock)
            state.open!(Node::Text.new(content)) unless content.empty?
          else
            state.store!(Node::Text.new(content)) unless content.empty?
          end

          state.store!(Mquve::Node::LineBreak.new) if state.content.match?(/ {2,}$/)

          state
        end
      end
    end
  end
end
