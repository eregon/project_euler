=begin
We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier, and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.
=end

require_relative 'lib/integer'
require_relative 'lib/array/to_i'

pandigitals = []
(1..2000).each { |a|
  a_digits = a.digits
  (1..100).each { |b|
    b_digits = b.digits
    if (a_digits & b_digits).empty?
      digits = a_digits+b_digits+(p = a*b).digits
      if digits.size == 9 && digits.to_i.pandigital?
        pandigitals << [a,b,p]
      end
    end
  }
}

pandigitals.each { |pd| p pd }
p pandigitals.map(&:last).uniq.reduce(:+) # => 45228, 1.27s

__END__
30424
45228
