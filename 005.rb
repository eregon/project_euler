# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

# This is in fact just a ppcm of the numbers, so the max[factors] of every divisor
require_relative 'lib'

p (1..20).map { |i|
  i.prime_factors.each_with_object({}) { |(factor, pow), h|
    h[factor] = pow
  }
}.each_with_object({}) { |factors, best_factors|
  best_factors.merge!(factors) { |factor, pow1, pow2|
    [pow1, pow2].max
  }
}.map { |factor, pow|
  factor**pow
}.reduce(:*) # => 232792560
