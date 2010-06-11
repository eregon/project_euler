=begin
Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:

    1634 = 1^(4) + 6^(4) + 3^(4) + 4^(4)
    8208 = 8^(4) + 2^(4) + 0^(4) + 8^(4)
    9474 = 9^(4) + 4^(4) + 7^(4) + 4^(4)

As 1 = 1^(4) is not a sum it is not included.

The sum of these numbers is 1634 + 8208 + 9474 = 19316.

Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.
=end

require_relative 'lib/integer/digits'

DIGITS = 5
p a=(2..10**(DIGITS+1)-1).select { |n|
    n.digits.inject(0) { |sum, digit| sum + digit**DIGITS } == n
} # => [4150, 4151, 54748, 92727, 93084, 194979]
p a.reduce(:+) # => 443839

# 1) 248860
# 2) 443839
