=begin
A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.

As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.

Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
=end

LIMIT = 28123

require_relative 'lib/integer'

class Integer
  def abundant?
    proper_divisors.reduce(:+) > self
  end
end

abundant_numbers = (1..LIMIT).select(&:abundant?)

p :abundants_selected

abundant_numbers_sums = abundant_numbers.combination(2).map { |a,b| a+b } +
abundant_numbers.map { |n| n*2 } # with itself

p :array_of_abundant_number_sum_created

#(1..LIMIT).select { |n|
#  (n.odd? or !abundant_numbers.include?(n/2)) and
#}

p ((1..LIMIT).to_a-abundant_numbers_sums).reduce(:+) # => 4179871

# 1) 31531501 with LIMIT/2
# 2) 4179871
