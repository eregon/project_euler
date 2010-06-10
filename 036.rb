=begin
The decimal number, 585 = 1001001001_(2) (binary), is palindromic in both bases.

Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.

(Please note that the palindromic number, in either base, may not include leading zeros.)
=end

class Integer
  def palindromic?
    base10 = to_s and base10 == base10.reverse and base2 = to_s(2) and base2 == base2.reverse
  end
end

p (1..1_000_000).inject(0) { |sum, n|
  n.palindromic? ? sum + n : sum
} # => 872187
