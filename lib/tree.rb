# frozen_string_literal: true

require "pry"
require_relative "node"

# Builds and maintains a binary search tree
class Tree
  attr_accessor :root_node

  def initialize(initial_array)
    @root_node = build_tree(initial_array)
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
    @root_node = root
  end
  # rubocop: enable Metrics/AbcSize

  def insert(value)
    new_node = Node.new(data: value)
    current_node = root_node

    loop do
      if new_node < current_node
        break if current_node.left_node.nil?

        current_node = current_node.left_node
      else
        break if current_node.right_node.nil?

        current_node = current_node.right_node
      end
    end
    new_node < current_node ? current_node.left_node = new_node : current_node.right_node = new_node
  end

  # The pretty_print method is fromhttps://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/binary-search-trees
  def pretty_print(node = @root_node, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end

end


# test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
test_array = [10, 20, 30, 40, 50]
tree = Tree.new(test_array)
p tree.root_node
tree.pretty_print
puts "\n\n\n"
tree.insert(64)
tree.pretty_print
