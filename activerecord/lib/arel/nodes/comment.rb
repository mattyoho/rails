# frozen_string_literal: true

module Arel # :nodoc: all
  module Nodes
    class Comment < Arel::Nodes::Node
      SQL_COMMENT_DELIMITER_PATTERN = /\/\*|\*\//.freeze

      attr_reader :value

      def initialize(value)
        super()
        value = sanitize_sql_comment_delimiters(value.to_s)
        @value = Arel.sql(value)
      end

      def initialize_copy(other)
        super
        @value = @value.clone if @value
      end

      def hash
        [@value].hash
      end

      def eql?(other)
        self.class == other.class &&
          self.value == other.value
      end
      alias :== :eql?

      private

        def sanitize_sql_comment_delimiters(str)
          while str.match?(SQL_COMMENT_DELIMITER_PATTERN)
            str = str.gsub(SQL_COMMENT_DELIMITER_PATTERN, "")
          end
          str
        end
    end
  end
end
