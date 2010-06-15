# By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.
#
# 3
# 7 4
# 2 4 6
# 8 5 9 3
#
# That is, 3 + 7 + 4 + 9 = 23.
#
# Find the maximum total from top to bottom of the triangle below:
#
# 75
# 95 64
# 17 47 82
# 18 35 87 10
# 20 04 82 47 65
# 19 01 23 75 03 34
# 88 02 77 73 07 63 67
# 99 65 04 28 06 16 70 92
# 41 41 26 56 83 40 80 70 33
# 41 48 72 33 47 32 37 16 94 29
# 53 71 44 65 25 43 91 52 97 51 14
# 70 11 33 28 77 73 17 78 39 68 17 57
# 91 71 52 38 17 14 91 43 58 50 27 29 48
# 63 66 04 68 89 53 67 30 73 16 69 87 40 31
# 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
#
# NOTE: As there are only 16384 routes, it is possible to solve this problem by trying every route. However, Problem 67, is the same challenge with a triangle containing one-hundred rows; it cannot be solved by brute force, and requires a clever method! ;o)
#

triangle = <<EOS
75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
EOS

triangle2 = <<EOS
3
7 4
2 4 6
8 5 9 3
EOS

triangle = triangle.lines.map { |line| line.chomp.split(' ').map(&:to_i) }

class Node
  attr_reader :value
  attr_accessor :neighbours, :visited
  alias :weight :value
  def initialize(value)
    @value = value
    @neighbours = []
    @visited = false
  end

  def to_s
    "#{@value}#{ " [#{@neighbours.map(&:value) * ','}]" if !@neighbours.empty? }"
  end
end
nodes = triangle.map { |row| row.map { |node| Node.new(node) } }
nodes[0...-1].each_with_index { |row, r|
  row.each_with_index { |node, n|
    node.neighbours = [nodes[r+1][n], nodes[r+1][n+1]].uniq
  }
}
source = nodes[0][0]

def longest_path(node, sum = node.weight, distances = Hash.new(0))
  distances[node] = sum if distances[node] < sum

  node.neighbours.each { |n|
    longest_path(n, sum + n.weight, distances)
  }
  distances
end

distances = longest_path(source)
p distances.values.max

puts
### Another way, faster
rows = triangle.map(&:dup)
rows[0...-1].each_with_index.reverse_each { |row, i|
  row.each_index { |j|
    row[j] += rows[i+1][j..j+1].max
  }
}

p rows[0][0] # => 1074
