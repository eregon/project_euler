=begin
It was proposed by Christian Goldbach that every odd composite number can be written as the sum of a prime and twice a square.

9 = 7 + 2×1^(2)
15 = 7 + 2×2^(2)
21 = 3 + 2×3^(2)
25 = 7 + 2×3^(2)
27 = 19 + 2×2^(2)
33 = 31 + 2×1^(2)

It turns out that the conjecture was false.

What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?
=end

require_relative 'lib/cached_prime/prime'
class Integer
  def golbach?
    return false if prime?
    (1..Math.sqrt(self/2).floor).each { |n|
      return true if (self-2*n*n).prime?
    }
    false
  end
end

p [9, 15, 21, 25, 27, 33].all?(&:golbach?)

p (3..9999).step(2) { |odd|
  next if odd.prime?
  break(odd) if !odd.golbach?
} # => 5777

