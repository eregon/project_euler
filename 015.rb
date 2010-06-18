=begin
Starting in the top left corner of a 2×2 grid,
 there are 6 routes (without backtracking) to the bottom right corner.
How many routes are there through a 20×20 grid?
=end

require_relative 'lib'

def test way
  puts way
  ((1..5).to_a << 20).each { |i| puts "#{i}*#{i}: #{yield i}" }
  puts
end

test(:theoric_combinations) { |n| (2*n).! / n.!**2 }

test(:generating_combinations) { |n|
  next "stopped because it takes forever ;)" if n == 20
  [:down, :right].repeated_permutation(2*n).select { |perm| perm.count(:down) == perm.size/2 }.size
}
