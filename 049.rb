=begin
The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases by 3330, is unusual in two ways: (i) each of the three terms are prime, and, (ii) each of the 4-digit numbers are permutations of one another.

There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes, exhibiting this property, but there is one other 4-digit increasing sequence.

What 12-digit number do you form by concatenating the three terms in this sequence?
=end

require_relative 'lib/cached_prime'
require_relative 'lib/integer/digits'

primes = CachedPrime.each(9999).reject { |prime| prime < 1000 }

primes.combination(3).each { |a, b, c| # a < b < c as combination respect order :)
  if (b-a) == (c-b) and a.digits.sort == b.digits.sort and b.digits.sort == c.digits.sort
    p [a,b,c]
  end
} # => 60s

__END__
[1487, 4817, 8147]
[2969, 6299, 9629]
