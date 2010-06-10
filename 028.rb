=begin
Starting with the number 1 and moving to the right in a clockwise direction a 5 by 5 spiral is formed as follows:

21 22 23 24 25
20  7  8  9 10
19  6  1  2 11
18  5  4  3 12
17 16 15 14 13

It can be verified that the sum of the numbers on the diagonals is 101.

What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way?
=end

# 0 square_size = 1
# 1 square_size = 8
# 2 square_size = 8+8=16
# i square_size = 8*i
square_size = -> i { 8*i }

SIZE = 1001
R = SIZE/2
border_square_size = square_size[R]

#####
n = 1
sum = 1
(1..R).each { |i|
  4.times {
    sum += (n += square_size[i]/4)
  }
}
p sum #=> 669171001
