# frozen_string_literal: true

require_relative "tree"

# test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
test_array = [10, 20, 30, 40, 50]
tree = Tree.new(test_array)
puts "The root node is:"
p tree.root_node
puts "\n\n\n"
puts "The starting tree:"
tree.pretty_print
puts "\n\n\n"

puts "Insert nodes:"
tree.insert(64)
tree.insert(22)
tree.pretty_print
puts "\n\n\n"

puts "Find 40. Node: #{tree.find(40)}, value: #{tree.find(40).data}"
puts "Find recursively 40. Node: #{tree.find_recursive(40)}, value: #{tree.find_recursive(40).data}"
puts "Level order using iteration: #{tree.level_order}"
puts "Level order using recurssion: #{tree.level_order_recursive}"
puts ""
puts "Insert using recurssion:"
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
puts "Set up for deletion checks:"
tree.insert(35)
tree.pretty_print
puts "\n\n"
# tree.insert(37)
puts "Delete:"
tree.delete(64)
tree.delete(10)
tree.pretty_print
puts "\n\n"
tree.delete(30)
tree.pretty_print
puts "\n\n"
puts "Balance checks"
tree.insert(60)
tree.pretty_print
puts "\n\n"
puts "The tree is balanced: #{tree.balanced?}"
puts "Rebalance tree. #{tree.rebalance}"
puts "\n\n"
tree.insert(70)
tree.insert(80)
tree.insert(6)
tree.insert(3)
tree.insert(90)
tree.pretty_print
puts "\n\n"
puts "The tree is balanced: #{tree.balanced?}"
puts ""
puts "Rebalanced tree:"
tree.rebalance
tree.pretty_print
puts "\n\n"
puts "The tree is balanced: #{tree.balanced?}"