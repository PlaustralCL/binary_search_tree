# frozen_string_literal: true

require "pry"
require_relative "node"

# Builds and maintains a binary search tree
class Tree
  attr_accessor :root

  def initialize(initial_array)
    @root = build_tree(initial_array)
  end

  # rubocop: disable Metrics/AbcSize
  def build_tree(array)
    return Node.new(data: array.first) if array.length == 1
    return nil if array.empty?

    array = array.uniq.sort
    middle = (array.length / 2)

    root = Node.new(data: array[middle])
    root.left_node = build_tree(array[0..middle - 1])
    root.right_node = build_tree(array[middle + 1..-1])
    @root = root
  end
  # rubocop: enable Metrics/AbcSize

end


test_array = [1, 2, 3, 4, 5]
tree = Tree.new(test_array)
p tree.root
