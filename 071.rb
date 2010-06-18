=begin
Consider the fraction, n/d, where n and d are positive integers. If n<d  and HCF(n,d)=1, it is called a reduced proper fraction.

If we list the set of reduced proper fractions for d ≤ 8 in ascending order of size, we get:

1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8

It can be seen that 2/5 is the fraction immediately to the left of 3/7.

By listing the set of reduced proper fractions for d ≤ 1,000,000 in ascending order of size, find the numerator of the fraction immediately to the left of 3/7.
=end

require "set"
rationals = SortedSet.new
min, target = Rational(0), Rational(3,7)
(2..1_000_000).each { |d|
  (d*min.numerator/min.denominator).upto(d*target.numerator/target.denominator) { |n|
    rationals << Rational(n, d) if n.gcd(d) == 1
  }
  if Math.log10(d) % 1 == 0 or d % 100_000 == 0
    puts "Updating min at d=#{d}"
    rationals = SortedSet.new(rationals.to_a[-2..-2]) if d == 10 # We need to remove *target* at the first time
    rationals = SortedSet.new [min = rationals.to_a.last]
    puts "min is now #{min}"
  end
}

puts rationals.to_a.last # => 428570/999997, 8s

#### With Farey Sequence
a = Rational(0)
while a.denominator < 1_000_000
  last = a
  a = Rational(a.numerator + 3, a.denominator + 7)
end
puts last
