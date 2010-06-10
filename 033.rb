=begin
The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.

We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

There are exactly four non-trivial examples of this type of fraction, less than one in value, and containing two digits in the numerator and denominator.

If the product of these four fractions is given in its lowest common terms, find the value of the denominator.
=end

require_relative 'lib/integer/digits'
require_relative 'lib/array/to_i'

class Integer
  def my_simplification n
    md, nd = self.digits, n.digits
    self < n and (1..9).any? { |i|
      [md,nd].all? { |d| d.include?(i) and !d.include?(0) and d.uniq != [i] } and
      Rational(md.tap{|d|d.delete(i)}.to_i, nd.tap{|d|d.delete(i)}.to_i) == Rational(self, n)
    }
  end
end

p 49.my_simplification(98)
p 30.my_simplification(50)

p (1..99).each_with_object([]) { |numerator, fractions|
  (1..99).each { |denominator|
    fractions << Rational(numerator, denominator) if numerator.my_simplification(denominator)
  }
}.reduce(:*) # => 100 # :O
