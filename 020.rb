# n! means n × (n  − 1) × ... × 3 × 2 × 1
# Find the sum of the digits in the number 100!

require_relative 'lib/integer/factorial'
require_relative 'lib/integer/digits'
p 100.!.digits.reduce(:+) # => 648
