# frozen_string_literal: true

module Mquve
  class Parser
    class Block
      def process(parent)
        state = State.new(nodes: [parent])

        parent.content.lines.each_with_index do |line, i|
          state.content = line

          match = state.content.match(/^(?<mark>(\s*>)+)(?<content>.*\n)$/)
          unless match
            state.close! while state.under?(Node::BlockQuote)
          end

          unless state.in?(Node::CodeBlock)
            loop do
              last_content = state.content
              break if BlockQuote.new.process(state)
              break if List.new.process(state)
              break if state.content == last_content
            end
          end

          content = state.content

          next if Comment.new.process(state)
          next if BlankLine.new.process(state)

          next if FencedCode.new.process(state)
          next if SetextHeading.new.process(state)
          next if HorizontalRule.new.process(state)

          if state.content == content && match = state.content.match(/^(?<indent> +)(?<content>.+\n)/)
            if match[:indent].length > state.current_item.attrs[:indent] + 3 && !state.in?(Node::Paragraph)
              state = IndentedCode.new.process(state)
            elsif match[:indent].length < state.current_item.attrs[:indent]
              2.times { state.close! } unless state.in?(Mquve::Node::BlockQuote)
              state.open!(Node::Paragraph.new) unless state.in?(Node::Paragraph)
              state.content = match[:content]
            else
              state.open!(Node::Paragraph.new) if !state.in?(Node::Paragraph) && !state.in?(Mquve::Node::CodeBlock)
              state.content = match[:content]
            end
          end

          next if AtxHeading.new.process(state)

          state.open!(Node::Paragraph.new) if !state.in?(Node::Paragraph) && !state.in?(Mquve::Node::CodeBlock) && !state.content.empty?
          state = String.new.process(state)

          state.current_list.attrs[:tight] = false if state.current_list && state.list_widable

          next unless i == parent.content.lines.length - 1

          state.close! until state.in?(Node::Document)
        end

        parent
      end
    end
  end
end
