=begin
It is possible to show that the square root of two can be expressed as an infinite continued fraction.

√ 2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...

By expanding this for the first four iterations, we get:

1 + 1/2 = 3/2 = 1.5
1 + 1/(2 + 1/2) = 7/5 = 1.4
1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...

The next three expansions are 99/70, 239/169, and 577/408, but the eighth expansion, 1393/985, is the first example where the number of digits in the numerator exceeds the number of digits in the denominator.

In the first one-thousand expansions, how many fractions contain a numerator with more digits than denominator?
=end

require_relative 'lib'

# numbers = [2,3,4]
# 2 + 1/( 3+1/( 4 ) )
# 2 + Rational(1,3 + Rational(1,4) )
def continued_fraction(numbers)
  numbers.reverse_each.inject(numbers.pop) { |r, n|
    n + Rational(1, r)
  }
end

p (1..1_000).count { |expansion|
  r = continued_fraction([1]+[2]*expansion)
  r.numerator.ndigits > r.denominator.ndigits
} # => 153, 4s

