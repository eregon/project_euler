=begin
It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits, but in a different order.

Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.
=end

TIMES_IDENTIC = 6

require_relative 'lib/integer/digits'

p (1..200_000).each { |n|
  digits = n.digits.sort
  break(n) if (TIMES_IDENTIC-1).times.all? { |i| (n*(i+2)).digits.sort == digits }
}

# 2) 125874
# 3-6) 142857
