# frozen_string_literal: true

require_relative "./lib/tree"

seeds = Array.new(15) { rand(1..100) }
tree = Tree.new(seeds)
puts "Initial tree:"
tree.pretty_print
puts "The tree is balanced: #{tree.balanced?}\n\n"

puts "Level order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Inorder: #{tree.inorder}"
puts "Postorder: #{tree.postorder}"
puts ""
extra_numbers = Array.new(5) { rand(101..200) }
extra_numbers.each { |num| tree.insert(num) }
puts "Tree with extra numbers:"
tree.pretty_print
puts "The tree is balanced: #{tree.balanced?}\n\n"
puts ""
tree.rebalance
tree.pretty_print
puts "The tree is balanced: #{tree.balanced?}\n\n"

puts "Level order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Inorder: #{tree.inorder}"
puts "Postorder: #{tree.postorder}"
