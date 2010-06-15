# A palindromic number reads the same both ways.
# The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
# Find the largest palindrome made from the product of two 3-digit numbers.

DIGITS = 3
the_biggest_int_of_digits = 10**DIGITS-1

require_relative 'lib'
p the_biggest_int_of_digits.downto(the_biggest_int_of_digits-10).map { |biggest_int_of_digits|
  biggest_int_of_digits.downto(1) { |i|
    product = biggest_int_of_digits*i
    break([biggest_int_of_digits, i, product]) if product.palindrome?
  }
}.max_by { |a, i, p| p.to_i }

# 2
p 999.times.each_with_object([]) { |a, palindromes|
  999.times { |b|
    prod = a*b
    palindromes << prod if prod.palindrome?
  }
}.max # => 906609
