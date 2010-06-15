=begin
In the 5 by 5 matrix below, the minimal path sum from the top left to the bottom right, by only moving to the right and down, is indicated in bold red and is equal to 2427.


131 673 234 103 18
201 96  342 965 150
630 803 746 422 111
537 699 497 121 956
805 732 524 37  331


Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target As...'), a 31K text file containing a 80 by 80 matrix, from the top left to the bottom right by only moving right and down.
=end

matrix = IO.read('data/matrix.txt').lines.map { |line| line.split(',').map(&:to_i) }

# each node of nodes must respond to #neighbours and #weight
def dijkstra_optimized(nodes, source, destination)
  dist = Hash.new(Float::INFINITY)
  dist[source] = 0
  q = nodes.dup

  until q.empty?
    u = q.min_by { |v| dist[v] }
    return dist[destination] if u == destination
    q.delete(u)
    u.neighbours.each do |v|
      alt = dist[u] + v.weight
      dist[v] = alt if alt < dist[v]
    end
  end
end

class Node
  attr_reader :weight
  attr_accessor :neighbours
  def initialize(weight)
    @weight = weight
    @neighbours = []
  end
end

nodes = matrix.map { |row|
  row.map { |i|
    Node.new(i)
  }
}

nodes.each_with_index { |row, i|
  row.each_with_index { |node, j|
    node.neighbours << nodes[i][j+1] if j+1 < row.size
    node.neighbours << nodes[i+1][j] if i+1 < nodes.size
  }
}

# p nodes[0][0].weight + dijkstra_optimized(nodes.flatten, nodes[0][0], nodes[-1][-1]) # => 427337, 11.82s

##### Another way, similar to #18 and #67
rows = matrix
rows.each_with_index.reverse_each { |row, i|
  row.each_index.reverse_each { |j|
    row[j] += [(rows[i+1] || [])[j], row[j+1]].compact.min || 0
  }
}

p rows[0][0] # => 427337, 0.06s

