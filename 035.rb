=begin
The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.

There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.

How many circular primes are there below one million?
=end

require "prime"
require_relative 'lib/cached_prime'
require_relative 'lib/cached_prime/prime'
require_relative 'lib/integer/digits'
require_relative 'lib/array/to_i'

class Integer
  def circular_prime?
    (digits = self.digits()).each_index.all? { |i|
      digits.rotate!(1).to_i.prime?
    }
  end
end

p CachedPrime.each(1_000_000).select { |prime|
  prime.circular_prime?
}.size # => 55, 1.5s vs 10s (7s with CachedPrime.each, without better .prime?)

