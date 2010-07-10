=begin
The first known prime found to exceed one million digits was discovered in 1999, and is a Mersenne prime of the form 2^(6972593)−1;
it contains exactly 2,098,960 digits.
Subsequently other Mersenne primes, of the form 2^(p)−1, have been found which contain more digits.

However, in 2004 there was found a massive non-Mersenne prime which contains 2,357,207 digits: 28433×2^(7830457)+1.

Find the last ten digits of this prime number.
=end

#n = 28433 * 2**7830457 + 1
#p = 2**7830457

require_relative 'lib'

class Integer
  def int_pow(power)
    add = 0
    until (primes_factors = power.prime_factors).size > 1
      power += 1
      add += 1
    end
    primes_factors = primes_factors.reverse.inject([]) { |pd, (prime, p_pow)| pd + [prime]*p_pow }
    n = primes_factors.inject(self) { |n, prime| n ** prime }
    n / 2**add
  end
end

#p 2*37*105817
power = (((2 ** 105817) ** 37) ** 2) / 2
n = 28433*power + 1

n = 28433*(2.int_pow(7830457)) + 1

puts 10.times.map { |i|
  n, rest = n.divmod(10)
  rest
}.reverse.join # => 8739992577

