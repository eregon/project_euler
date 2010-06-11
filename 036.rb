=begin
The decimal number, 585 = 1001001001_(2) (binary), is palindromic in both bases.

Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.

(Please note that the palindromic number, in either base, may not include leading zeros.)
=end

require_relative 'lib/integer/palindrome'

p (1..1_000_000).inject(0) { |sum, n|
  (n.palindrome?(10) and n.palindrome?(2)) ? sum + n : sum
} # => 872187
