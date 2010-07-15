=begin
It is well known that if the square root of a natural number is not an integer, then it is irrational. The decimal expansion of such square roots is infinite without any repeating pattern at all.

The square root of two is 1.41421356237309504880..., and the digital sum of the first one hundred decimal digits is 475.

For the first one hundred natural numbers, find the total of the digital sums of the first one hundred decimal digits for all the irrational square roots.
=end

require_relative 'lib'
require "bigdecimal"
require "bigdecimal/math"
include BigMath

def digital_sum_of_100_decimals(n)
  n.to_s('F')[0..100].chars.inject(0) { |sum, chr| sum + chr.to_i }
end

def sqrt_of(n)
  sqrt(BigDecimal.new(n.to_s), 100)
end

p (1...100).reject { |n|
  Math.sqrt(n).whole?
}.inject(0) { |sum, n|
  sum + digital_sum_of_100_decimals(sqrt_of(n))
} # => 40886
