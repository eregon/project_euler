# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
# Find the sum of all the primes below two million.

require_relative 'lib'
p CachedPrime.each(2_000_000).inject { |sum, prime|
  sum + prime
} # => 142913828922, 0.16s vs 7.41s
