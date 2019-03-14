# frozen_string_literal: true

module Arel # :nodoc: all
  module Nodes
    class Annotation < Arel::Nodes::Node
      include Arel::Nodes::SqlCommentSanitization

      attr_reader :values

      def initialize(*values)
        super()
        @values = values.map do |value|
          next value if value.is_a?(Arel::Nodes::SqlLiteral)
          value = scrub_block_comment_delimiters(value)
          Arel.sql(value)
        end
      end

      def initialize_copy(other)
        super
        @values = @values.clone
      end

      def hash
        [@values].hash
      end

      def eql?(other)
        self.class == other.class &&
          self.values == other.values
      end
      alias :== :eql?
    end
  end
end
