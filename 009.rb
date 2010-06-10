# A Pythagorean triplet is a set of three natural numbers, a  < b  < c, for which,
# a^(2) + b^(2) = c^(2)
# 
# For example, 3^(2) + 4^(2) = 9 + 16 = 25 = 5^(2).
# 
# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.

def find_Pythagorean_triplet(n)
  1.upto(n) { |a|
    1.upto(n) { |b|
      c = Math.hypot(a, b)
      return (a*b*c).to_i if c.floor == c && a+b+c == n
    }
  }
end

p find_Pythagorean_triplet(1000) # => 31875000

