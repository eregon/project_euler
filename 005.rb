# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

N = 20

n = 2520 # [[2 ** 3], [3 ** 2], [5], [7]]
p 10.downto(1).all? { |d|
  (n % d).zero?
}

# This is inf act just a ppcm of the numbers, so the max[factors] of every divisor
require "prime"
p (2..N).map { |i|
  Prime.prime_division(i).each_with_object({}) { |(factor, pow), h|
    h[factor] = pow
  }
}.each_with_object({}) { |factors, best_factors|
  best_factors.merge!(factors) { |factor, pow1, pow2|
    [pow1, pow2].max
  }
}.map { |factor, pow|
  factor**pow
}.reduce(:*)
