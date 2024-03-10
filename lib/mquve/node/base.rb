# frozen_string_literal: true

module Mquve
  class Node
    class Base
      def inlinize
        self
      end

      def inner_html
        children.map(&:outer_html).join
      end

      alias outer_html inner_html
      alias html outer_html
    end
  end
end
