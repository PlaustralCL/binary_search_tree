# frozen_string_literal: true

# Stores individual nodes for the binary search tree
class Node
  include Comparable

  attr_accessor :data, :left_node, :right_node

  def initialize(data: nil, left_node: nil, right_node: nil)
    @data = data
    @left_node = left_node
    @right_node = right_node
  end

  def <=>(other)
    data <=> other.data
  end

end