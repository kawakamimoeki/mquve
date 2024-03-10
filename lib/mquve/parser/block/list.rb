# frozen_string_literal: true

module Mquve
  class Parser
    class Block
      class List
        def process(state)
          match = state.content.match(/^(?<base> *)(?<text>(?<indent>(?<num>[0-9]{1,9})(?<delimiter>[.)])|(?<bullet>[-*+]))((?<space>\s+)(?<content>.+\n)|(?<space>)(?<content>)))/)

          return false unless match

          if !state.current_list.instance_of?(Node::Document) && state.current_list && (match[:base] + match[:indent] + match[:space]).length > state.current_list.attrs[:indent] + 3
            if state.current_list.attrs[:tight]
              state.content = match[:text]
            else
              2.times { state.close! }
            end
            return true
          end

          if !state.under?(Node::List) && state.in?(Node::Paragraph) && match[:num] && match[:num].to_i != 1
            state.content = match[0]
            return false
          end

          state.close! if state.in?(String)

          attrs = { start: match[:num], tight: true, type: match[:bullet] ? :bullet : :ordered, base: match[:base].length, indent: (match[:base] + match[:indent] + match[:space]).length, bullet: match[:bullet], delimiter: match[:delimiter] }

          if state.current_list && (state.current_list.attrs[:bullet] != match[:bullet] || state.current_list.attrs[:delimiter] != match[:delimiter])
            3.times { state.close! } if state.under?(Node::List)
            state.close! if state.under?(Node::Paragraph)
            list = Node::List.new(attrs: attrs)
            state.list_widable = false
            state.open!(list)
          elsif state.in?(Node::Document) || ((match[:base] + match[:indent] + match[:space]).length > state.current_item.attrs[:indent] + 1)
            state.close! if state.in?(Node::Paragraph)
            state.list_widable = false
            list = Node::List.new(attrs: attrs)
            state.open!(list)
          end

          if match[:base].length < state.current_item.attrs[:indent] && match[:base].length < state.current_list.attrs[:indent] + 2
            state.close! until state.in?(Node::Document) || (state.in?(Node::List) && state.bottom.attrs[:indent] <= (match[:base] + match[:indent] + match[:space]).length)
          end

          item = Node::Item.new(parent: state.current_list, attrs: { start: match[:num], indent: (match[:base] + match[:indent] + match[:space]).length, bullet: match[:bullet], delimiter: match[:delimiter] })
          state.open!(item)
          if match[:content].empty?
            state.content = ''
          else
            state.open!(Node::Paragraph.new(parent: item))
            state.content = match[:content]
          end
          false
        end
      end
    end
  end
end
