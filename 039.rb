=begin
If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.

{20,48,52}, {24,45,51}, {30,40,50}

For which value of p ≤ 1000, is the number of solutions maximised?
=end

p (1..1000).max_by { |p|
  (1...p/3).inject(0) { |count, a| # c is the hypotenuse, and a is the smallest side, so a < p/3
    count + (a...(p-a)/2).count { |b| # b is smaller than c, so b < (p-a)/2
      c = p - a - b
      a*a + b*b == c*c
    }
  }
} # => 840, 8s
