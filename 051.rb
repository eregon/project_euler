=begin
By replacing the 1^(st) digit of *3, it turns out that six of the nine possible values: 13, 23, 43, 53, 73, and 83, are all prime.

By replacing the 3^(rd) and 4^(th) digits of 56**3 with the same digit,
 this 5-digit number is the first example having seven primes among the ten generated numbers,
   yielding the family: 56003, 56113, 56333, 56443, 56663, 56773, and 56993. Consequently 56003,
    being the first member of this family, is the smallest prime with this property.

Find the smallest prime which, by replacing part of the number (not necessarily adjacent digits) with the same digit, is part of an eight prime value family.
=end

require_relative 'lib'
CachedPrime.find { |prime|
  next if prime < 56003
  digits = prime.digits
  (2..digits.size).each { |n_digits_to_take|
    digits.combination(n_digits_to_take).each { |e|  }
  }
}

