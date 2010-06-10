# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
# Find the sum of all the primes below two million.

#require "prime"
require_relative 'lib/cached_prime'
p CachedPrime.inject { |sum, prime|
  break(sum) if prime > 2_000_000
  sum + prime
} # => 142913828922, 0.16s vs 7.41s
