=begin
145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

Find the sum of all numbers which are equal to the sum of the factorial of their digits.

Note: as 1! = 1 and 2! = 2 are not sums they are not included.
=end
require_relative 'lib/integer/digits'
class Integer
  def !
    (1..self).inject(1) { |fact, i| fact*i }
  end
  def sum_of_factorial_digits?
    digits.map(&:!).reduce(:+) == self
  end
end

p (3..100_000).select { |i| i.sum_of_factorial_digits? }.reduce(:+)

# 1) 1000 => 145
# 2) 100_000, 1_000_000 => 40730
