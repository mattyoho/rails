# frozen_string_literal: true

module Arel # :nodoc: all
  module Nodes
    module SqlCommentSanitization
      BLOCK_COMMENT_DELIMITER_PATTERN = /\/\*|\*\//.freeze

      def scrub_block_comment_delimiters(str)
        while str.match?(BLOCK_COMMENT_DELIMITER_PATTERN)
          str = str.gsub(BLOCK_COMMENT_DELIMITER_PATTERN, "")
        end
        str
      end

      extend self
    end
  end
end
