# frozen_string_literal: true

require_relative "../helper"
require "yaml"

module Arel
  module Nodes
    class CommentTest < Arel::Spec
      before do
        @visitor = Visitors::ToSql.new Table.engine.connection
      end

      def compile(node)
        @visitor.accept(node, Collectors::SQLString.new).value
      end

      describe "equality" do
        it "is equal with equal contents" do
          array = [Comment.new("foo"), Comment.new("foo")]
          assert_equal 1, array.uniq.size
        end

        it "is not equal with different contents" do
          array = [Comment.new("foo"), Comment.new("bar")]
          assert_equal 2, array.uniq.size
        end
      end

      describe "SQL injection protection" do
        it "strips SQL comment delimiters from value" do
          node = Comment.new("*/foo/*")
          compile(node).must_be_like %{ /* foo */ }

          node = Comment.new("**//foo//**")
          compile(node).must_be_like %{ /* foo */ }
        end
      end
    end
  end
end
