# frozen_string_literal: true

require "pry"
require_relative "node"

# Builds and maintains a binary search tree
# rubocop: disable Metrics/ClassLength
class Tree
  attr_accessor :root_node

  def initialize(initial_array)
    @root_node = build_tree(initial_array)
  end

  # rubocop:todo Metrics/AbcSize
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

  def insert_recursive(value, root = root_node)
    return Node.new(data: value) unless root

    if value < root.data
      root.left_node = insert_recursive(value, root.left_node)
    else
      root.right_node = insert_recursive(value, root.right_node)
    end
    root
  end

  def find(value)
    current_node = root_node
    loop do
      return current_node if current_node.data == value

      current_node = if value < current_node.data
                       current_node.left_node
                     else
                       current_node.right_node
                     end
    end
  end

  def find_recursive(value, root = root_node, target_node = [])
    return unless root

    target_node << root if root.data == value
    find_recursive(value, root.left_node, target_node)
    find_recursive(value, root.right_node, target_node)

    target_node.first
  end

  def level_order
    queue = [root_node]
    level_order_list = []
    until queue.empty?
      level_order_list << queue.first.data
      queue << left(queue) unless left(queue).nil?
      queue << right(queue) unless right(queue).nil?
      queue.shift
    end
    level_order_list
  end

  def level_order_recursive(root = root_node, level_order_list = [root_node.data])
    return unless root

    level_order_list << root.left_node.data unless root.left_node.nil?
    level_order_list << root.right_node.data unless root.right_node.nil?

    level_order_recursive(root.left_node, level_order_list)
    level_order_recursive(root.right_node, level_order_list)

    level_order_list
  end

  def preorder(root = root_node, dfs_list = [])
    return unless root

    dfs_list << root.data
    preorder(root.left_node, dfs_list)
    preorder(root.right_node, dfs_list)

    dfs_list
  end

  def inorder(root = root_node, dfs_list = [])
    return unless root

    inorder(root.left_node, dfs_list)
    dfs_list << root.data
    inorder(root.right_node, dfs_list)

    dfs_list
  end

  def postorder(root = root_node, dfs_list = [])
    return unless root

    postorder(root.left_node, dfs_list)
    postorder(root.right_node, dfs_list)
    dfs_list << root.data

    dfs_list
  end

  def height(root = root_node)
    return -1 unless root

    [height(root.left_node), height(root.right_node)].max + 1
  end

  def depth(value)
    current_node = root_node
    node_depth = 0
    loop do
      return node_depth if current_node.data == value

      node_depth += 1
      current_node = next_node(current_node, value)
    end
  end

  def delete(value)
    current_node, previous_node = find_target_node(value)

    if current_node.left_node.nil? && current_node.right_node.nil?
      delete_with_no_children(value, previous_node)
    elsif current_node.left_node.nil? || current_node.right_node.nil?
      delete_with_one_child(value, current_node, previous_node)
    else
      delete_with_two_children(current_node)
    end
  end

  def delete_with_two_children(current_node)
    replacement_node = min_value_node(current_node.right_node)
    delete(replacement_node.data)
    current_node.data = replacement_node.data
  end

  def delete_with_one_child(value, current_node, previous_node)
    if value < previous_node.data
      previous_node.left_node = current_node.left_node || current_node.right_node
    else
      previous_node.right_node = current_node.left_node || current_node.right_node
    end
  end

  def delete_with_no_children(value, previous_node)
    if value < previous_node.data
      previous_node.left_node = nil
    else
      previous_node.right_node = nil
    end
  end

  def find_target_node(value)
    current_node = root_node
    previous_node = current_node
    loop do
      break if current_node.data == value

      previous_node = current_node
      current_node = next_node(current_node, value)
    end
    [current_node, previous_node]
  end

  def min_value_node(node)
    current_node = node
    current_node = current_node.left_node while current_node.left_node
    current_node
  end

  def next_node(current_node, value)
    if value < current_node.data
      current_node.left_node
    else
      current_node.right_node
    end
  end

  def left(array)
    array.first.left_node
  end

  def right(array)
    array.first.right_node
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
tree.insert(22)
tree.pretty_print
puts "\n\n\n"
puts "Find 40. Node: #{tree.find(40)}, value: #{tree.find(40).data}"
puts "Find recursively 40. Node: #{tree.find_recursive(40)}, value: #{tree.find_recursive(40).data}"
tree.pretty_print
puts "\n\n\n"
puts "Level order using iteration: #{tree.level_order}"
puts "Level order using recurssion: #{tree.level_order_recursive}"
tree.insert_recursive(12)
tree.pretty_print
puts "\n\n"
puts "Preorder traversal results: #{tree.preorder}"
puts "Inorder traversal results: #{tree.inorder}"
puts "Postorder traversal results: #{tree.postorder}"
puts ""
puts "Depth of 40: #{tree.depth(40)}"
puts "Depth of 30: #{tree.depth(30)}"
puts "Depth of 12: #{tree.depth(12)}"
puts ""
puts "Height of 20: #{tree.height(tree.find(20))}"
puts "Height of 30: #{tree.height(tree.find(30))}"
puts "height of 64: #{tree.height(tree.find(64))}"
puts ""
tree.insert(35)
tree.insert(37)
tree.delete(64)
tree.delete(10)
tree.pretty_print
puts "\n\n"
tree.delete(30)
tree.pretty_print
puts "\n\n"
p tree.inorder