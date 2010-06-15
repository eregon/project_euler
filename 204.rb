=begin
A Hamming number is a positive number which has no prime factor larger than 5.
So the first few Hamming numbers are 1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15.
There are 1105 Hamming numbers not exceeding 10^(8).

We will call a positive number a generalised Hamming number of type n, if it has no prime factor larger than n.
Hence the Hamming numbers are the generalised Hamming numbers of type 5.

How many generalised Hamming numbers of type 100 are there which don't exceed 10^(9)?
=end

require_relative 'lib'

def hamming_number(n = 1, primes, limit)
  primes.inject(1) { |result, prime|
    break(result) if n*prime > limit
    result + hamming_number(n*prime, primes[primes.index(prime)..-1], limit)
  }
end

p hamming_number(CachedPrime.each(100).to_a, 10**9) # => 2944730, 6s

