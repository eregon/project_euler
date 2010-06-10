=begin
The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.

Find the sum of the only eleven primes that are both truncatable from left to right and right to left.

NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
=end

require_relative 'lib/integer/digits'
require_relative 'lib/array/to_i'
class Integer
  def truncatable_prime?
    digits = self.digits
    (digits.size-1).times.all? { |i|
      digits[i+1..-1].to_i.prime? && digits[0..-2-i].to_i.prime?
    }
  end
  def prime?
    Prime.prime?(self)
  end
end

require "prime"

truncatable_primes = Prime.each_with_object([]) { |prime, truncatable_primes|
  next if prime < 8
  truncatable_primes << prime if prime.truncatable_prime?
  break(truncatable_primes) if truncatable_primes.size == 11
} # => [23, 37, 53, 73, 313, 317, 373, 797, 3137, 3797, 739397]

p truncatable_primes.reduce(:+) # => 748317
