=begin
A googol (10^(100)) is a massive number: one followed by one-hundred zeros; 100^(100) is almost unimaginably large: one followed by two-hundred zeros. Despite their size, the sum of the digits in each number is only 1.

Considering natural numbers of the form, a^(b), where a, b < 100, what is the maximum digital sum?
=end

require_relative 'lib/integer/digits'
p (1..99).inject(0) { |best, a|
  best_b = (1..99).max_by { |b|
    (a**b).digits.reduce(:+)
  }
  digital_sum = (a**best_b).digits.reduce(:+)
  [best, digital_sum].max
} # => 972
